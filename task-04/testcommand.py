from telegram import Update
from telegram.ext import Application, CommandHandler, ContextTypes, MessageHandler,filters

TOKEN = '7358428064:AAGoWlaB_3VxTENZBhM9iONvYzpRmQkCXNA'

async def start(update: Update, context: ContextTypes.DEFAULT_TYPE):
    await update.message.reply_text('Welcome to the bot! How can I assist you today?')

if __name__=='main':
    app=Application.builder().token(TOKEN).build()
    app.add_handler(CommandHandler('start',start)) 
