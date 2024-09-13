from telegram import Update
from telegram.ext import ApplicationBuilder, CommandHandler, ContextTypes

# Replace 'YOUR_TOKEN_HERE' with your actual bot token from BotFather
TOKEN = '7358428064:AAGoWlaB_3VxTENZBhM9iONvYzpRmQkCXNA'

from telegram import Bot
import asyncio

async def check_updates():
    bot = Bot(token=TOKEN)
    updates = await bot.get_updates()
    for update in updates:
        print(update)

# Run the async function
if __name__ == '__main__':
    asyncio.run(check_updates())


# Define the /start command function
async def start(update: Update, context: ContextTypes.DEFAULT_TYPE) -> None:
    await update.message.reply_text('Welcome to the bot! How can I assist you today?')

# Main function to set up the bot and start polling for updates
async def main():
    # Create an Application object with your bot's token
    app = ApplicationBuilder().token(TOKEN).build()

    # Register a handler for the /start command
    app.add_handler(CommandHandler("start", start))

    # Start the bot
    await app.initialize()
    await app.start()
    print("Bot is running...")

    # Keep the bot running until you manually stop it
    try:
        await app.stop()  # Use stop() to stop the bot gracefully
    except KeyboardInterrupt:
        print("Bot stopped manually")

# Run the bot when the script is executed directly
if __name__ == '__main__':
    import asyncio
    asyncio.run(main())
