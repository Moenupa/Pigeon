class opacityCalculator():
    @staticmethod
    def hex_to_int(hex_num: str) -> int:
        return int(hex_num, base = 16)

    @staticmethod
    def hex_to_rgb(RGB: str) -> list:
        RGB = RGB.replace("#", "")
        return [hex_to_int(RGB[i,i+2]) for i in range(0,5,2)]

    @staticmethod
    def rgb_to_hex(arr_RGB: list) -> str:
        prefix = "#"
        return prefix + ''.join(hex(i)[-2:] for i in arr_RGB).upper()

    @staticmethod
    def floatOpCal(opacity: float, overlay: str, background: str) -> str:
        '''
        Calculate cover color with color transparency
        cover color = opacity * overlay + (1 - opacity) * background
        @param overlay, background: "#RRGGBB" or "RRGGBB"
        @param opacity: float of 0~1
        '''
        overlay_hex = hex_to_rgb(overlay)
        background_hex = hex_to_rgb(background)
        
        cover_color = [
            int(opacity * overlay_hex[i] + (1 - opacity) * background_hex[i])
            for i in range(3)
        ]

        return rgb_to_hex(cover_color)

    @staticmethod
    def hexOpCal(overlay: str, background: str) -> str:
        '''
        Calculate cover color with color transparency
        cover color = opacity * overlay + (1 - opacity) * background
        @param overlay: "#RRGGBBTT" or "RRGGBBTT"
        @param background: "#RRGGBB" or "RRGGBB"
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

    print(opacityCalculator.hexOpCal(PigeonDark["blue"]+"3E", PigeonDark["black"]))
        

    # origin "#155221"
    # origin "#32593D"