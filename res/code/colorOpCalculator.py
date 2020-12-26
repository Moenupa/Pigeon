def hex_to_rgb(color: str) -> list:
    color = color.replace("#", "")
    return [int(color[2*i:(2*i+2)], base = 16) for i in range(3)]

def rgb_to_hex(r: int, g: int, b: int) -> str:
    return '' + ''.join(hex(i)[-2:] for i in (r, g, b)).upper()
    
def depacker(rgb_array: list) -> str:
    return rgb_to_hex(rgb_array[0], rgb_array[1], rgb_array[2])

def colorOpCalculator(opacity: float, overlay: str, background: str) -> str:
    '''
    Calculate color transparency
    cover color = opacity * overlay + (1 - opacity) * background
    @param accept "#RRGGBB" or "RRGGBB"
    '''
    overlay_hex = hex_to_rgb(overlay)
    background_hex = hex_to_rgb(background)
    
    cover_color = [
        int(opacity * overlay_hex[i] + (1 - opacity) * background_hex[i])
        for i in range(3)
    ]

    return depacker(cover_color)


if __name__ == "__main__":
    PigeonDark = {
        "name": "Pigeon Dark",
        "author": "Moenupa",

        "foreground": "#D4D4D4",
        "background": "#1E1E1E",

        "cursorColor": "#FFFFFF",
        "selectionBackground": "#999999",

        "black":        "#1E1E1E",
        "red":          "#CC6666",
        "green":        "#8FCC66",
        "yellow":       "#CCB866",
        "blue":         "#66A3CC",
        "purple":       "#B866CC",
        "cyan":         "#66CCA3",
        "white":        "#999999",

        "brightBlack":  "#666666",
        "brightRed":    "#FF8080",
        "brightGreen":  "#B2FF80",
        "brightYellow": "#FFE680",
        "brightBlue":   "#80CCFF",
        "brightPurple": "#E680FF",
        "brightCyan":   "#80FFCC",
        "brightWhite":  "#EFEFEF"   
    }

    for color in ["red", "green", "yellow", "blue", "purple", "cyan", "white"]:
        print("{0}{1}\t{2}".format("dark", color.title(), colorOpCalculator(0.5, PigeonDark[color], PigeonDark["background"])))
        

    # origin "#155221"
    # origin "#32593D"