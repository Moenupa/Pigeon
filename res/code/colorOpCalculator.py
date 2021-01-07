def hex_to_int(hex_num: str) -> int:
    return int(hex_num, base = 16)

def hex_to_rgb(rgb: str) -> list:
    rgb = rgb.replace("#", "")
    return [hex_to_int(rgb[i:(i+2)]) for i in range(0,5,2)]

def rgb_to_hex(arr_RGB: list) -> str:
    prefix = "#"
    return prefix + ''.join(hex(i)[-2:] for i in arr_RGB).upper()

def floatOpCal(opacity: float, overlay: str, background: str) -> str:
    '''
    Calculate cover color with color transparency
    ``cover color = opacity * overlay + (1 - opacity) * background``

    Args:
        ``overlay`` and ``background``: in format ``#RRGGBBTT`` or ``RRGGBBTT``
        `opacity`: float, 0~1
    
    Returns:
        string ""
    '''
    overlay_hex = hex_to_rgb(overlay)
    background_hex = hex_to_rgb(background)
    
    cover_color = [
        int(opacity * overlay_hex[i] + (1 - opacity) * background_hex[i])
        for i in range(3)
    ]

    return rgb_to_hex(cover_color)

def hexOpCal(overlay: str, background: str, flag: bool) -> str:
    '''
    Calculate cover color with color transparency

    formula ``cover color = opacity * overlay + (1 - opacity) * background``

    Args:
        ``overlay`` and ``background``: in format #RRGGBBTT or RRGGBBTT;
    
    Returns:
        string ""
    '''

    opacity = hex_to_int(overlay[-2:])/256.0

    overlay_hex = hex_to_rgb(overlay)
    background_hex = hex_to_rgb(background)
    
    cover_color = [
        int(opacity * overlay_hex[i] + (1 - opacity) * background_hex[i])
        for i in range(3)
    ]

    return rgb_to_hex(cover_color)

if __name__ == "__main__":
    PigeonDark = {
        "name": "Pigeon Dark",
        "author": "Moenupa",

        "foreground": "#D4D4D4",
        "background": "#1E1E1E",

        "cursorColor": "#FFFFFF",
        "selectionBackground": "#999999",

        "darkBlack"  : "#000000", "black"  : "#1E1E1E", "brightBlack"  : "#3E3E3E",
        "darkGray"   : "#666666", "gray"   : "#999999", "brightGray"   : "#A6A6A6",
        "darkWhite"  : "#BBBBBB", "white"  : "#D4D4D4", "brightWhite"  : "#EFEFEF",
        "darkRed"    : "#754242", "red"    : "#CC6666", "brightRed"    : "#FF8080",
        "darkOrange" : "#755642", "orange" : "#CC8F66", "brightOrange" : "#FFB280",
        "darkYellow" : "#756B42", "yellow" : "#CCB866", "brightYellow" : "#FFE680",
        "darkGreen"  : "#567542", "green"  : "#8FCC66", "brightGreen"  : "#B2FF80",
        "darkCyan"   : "#427560", "cyan"   : "#66CCA3", "brightCyan"   : "#80FFCC",
        "darkBlue"   : "#426075", "blue"   : "#66A3CC", "brightBlue"   : "#80CCFF",
        "darkMagenta": "#6B4275", "magenta": "#B866CC", "brightMagenta": "#E680FF",
        "darkPink"   : "#754260", "pink"   : "#CC66A3", "brightPink"   : "#FF80CC"
    }

    PigeonLight = {
        "name": "Pigeon Light",
        "author": "Moenupa",
        
        "foreground": "#1E1E1E",
        "background": "#FFFFFF",
        
        "currentLineBackground": "EFEFEF",
        "selectionBackground": "#D4D4D4",
        
        "cursorColor": "#000000",
        
        "darkBlack"  : "#000000", "black"  : "#1E1E1E", "brightBlack"  : "#3E3E3E",
        "darkGray"   : "#666666", "gray"   : "#999999", "brightGray"   : "#A6A6A6",
        "darkWhite"  : "#BBBBBB", "white"  : "#D4D4D4", "brightWhite"  : "#EFEFEF",

        "darkRed"    : "#754242", "red"    : "#E64B43", "brightRed"    : "#FF3B30",
        "darkYellow" : "#755642", "yellow" : "#E6BC17", "brightYellow" : "#FFCC00",
        "darkOrange" : "#756B42", "orange" : "#E68F17", "brightOrange" : "#FF9500",
        "darkGreen"  : "#567542", "green"  : "#3EAD5A", "brightGreen"  : "#34C759",
        "darkCyan"   : "#427560", "cyan"   : "#67BAE0", "brightCyan"   : "#5AC8FA",
        "darkBlue"   : "#426075", "blue"   : "#177BE6", "brightBlue"   : "#007AFF",
        "darkMagenta": "#6B4275", "magenta": "#A25CC4", "brightMagenta": "#AF52DE",
        "darkPink"   : "#754260", "pink"   : "#E6405F", "brightPink"   : "#FF2D55"
    }

    for color in ["red", "yellow", "orange", "green", "cyan", "blue", "magenta", "pink"]:
        print("rgb-{0}: {1}".format(color, ",".join(str(i) for i in hex_to_rgb(PigeonDark[color]))))
        #print(floatOpCal(0.5, PigeonLight[color], "#FFFFFF"))
        

    # origin "#155221"
    # origin "#32593D"