from flavortext import loading_animation as ft

summon = input('summon dragon? y/n: ')
if summon == 'y':
    print('dragon being summoned...')
    ft(duration=10, interval=0.8)
    print('dragon has been summoned!')