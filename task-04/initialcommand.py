import asyncio
import telegram


async def main():
    bot = telegram.Bot("AIzaSyCJ97LSHZMd_sxNRLQglR_z-tMaLxxHNp8")
    async with bot:
        print(await bot.get_me())


if __name__ == '__main__':
    asyncio.run(main())
