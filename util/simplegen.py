import fontforge
import sys
CURRENT_FONT = fontforge.open(sys.argv[1])
# if sys.argv[3] == 'win':
#     CURRENT_FONT.os2_winascent  = 2177
#     CURRENT_FONT.os2_windescent = 744
CURRENT_FONT.generate(sys.argv[2],flags=('opentype'))
