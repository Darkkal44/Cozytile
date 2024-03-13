from libqtile import bar, widget, qtile
from libqtile.config import Screen
from .pallete import colors

widget_defaults = dict(
    font="sans",
    fontsize=12,
    padding=3,
)
extension_defaults = [ widget_defaults.copy()
        ]



def search():
    qtile.cmd_spawn("rofi -show drun")

def power():
    qtile.cmd_spawn("sh -c ~/.config/rofi/scripts/power")

# █▄▄ ▄▀█ █▀█
# █▄█ █▀█ █▀▄



screens = [

    Screen(
        top=bar.Bar(
            [
				widget.Spacer(length=15,
                    background=colors[1],
                ),


                widget.Image(
                    filename='~/.config/qtile/Assets/launch_Icon.png',
                    margin=2,
                    background=colors[1],
                    mouse_callbacks={"Button1":power},
                ),


                widget.Image(
                    filename='~/.config/qtile/Assets/6.png',
                ),


                widget.GroupBox(
                    fontsize=14,
                    borderwidth=0,
                    highlight_method='block',
                    active=colors[2],
                    block_highlight_text_color=colors[3],
                    highlight_color=colors[4],
                    inactive=colors[1],
                    foreground=colors[4],
                    background=colors[5],
                    this_current_screen_border=colors[5],
                    this_screen_border=colors[5],
                    other_current_screen_border=colors[5],
                    other_screen_border=colors[5],
                    urgent_border=colors[5],
                    rounded=True,
                    disable_drag=True,
                ),


                widget.Spacer(
                    length=8,
                    background=colors[5],
                ),


                widget.Image(
                    filename='~/.config/qtile/Assets/1.png',
                ),


                widget.Image(
                    filename='~/.config/qtile/Assets/layout.png',
                    background=colors[5],
                ),
                

                widget.CurrentLayout(
                    background=colors[5],
                    foreground=colors[2],
                    fmt='{}',
                    font="JetBrains Mono Bold",
                    fontsize=13,
                ),

                widget.Image(
                    filename='~/.config/qtile/Assets/1.png',
                ),

                # widget.Image(
                #     filename='~/.config/qtile/Assets/5.png',
                # ),


                # widget.Image(
                #     filename='~/.config/qtile/Assets/search.png',
                #     margin=2,
                #     background=colors[1],
                #     mouse_callbacks={"Button1": search},
                # ),

                # widget.TextBox(
                #     fmt='Search',
                #     background=colors[1],
                #     font="JetBrains Mono Bold",
                #     fontsize=13,
                #     foreground=colors[2],
                #     mouse_callbacks={"Button1": search},
                # ),


                # widget.Image(
                #     filename='~/.config/qtile/Assets/4.png',
                # ),

                widget.WindowName(
                    background = colors[5],
                    format = "{name}",
                    font='JetBrains Mono Bold',
                    foreground=colors[2],
                    empty_group_string = 'Desktop',
                    fontsize=13,
                ),

                widget.Image(
                    filename='~/.config/qtile/Assets/3.png',
                ),


                widget.Systray(
                    background=colors[1],
                    fontsize=2,
                ),


                widget.TextBox(
                    text=' ',
                    background=colors[1],
                ),


                widget.Image(
                    filename='~/.config/qtile/Assets/6.png',
                    background=colors[5],
                ),


                widget.Image(
                filename='~/.config/qtile/Assets/Drop1.png',
                ),

                widget.Net(
                format=' {up}   {down} ',
                background=colors[5],
                foreground=colors[2],
                font="JetBrains Mono Bold",
                prefix='k',
                ),

                # widget.Image(
                #     filename='~/.config/qtile/Assets/2.png',
                # ),

                # widget.Spacer(
                #     length=6,
                #     background=colors[5],
                # ),


                # widget.Image(
                #     filename='~/.config/qtile/Assets/Misc/ram.png',
                #     background=colors[5],
                # ),


                # widget.Spacer(
                #     length=-7,
                #     background=colors[5],
                # ),


                # widget.Memory(
                #     background=colors[5],
                #     format='{MemUsed: .0f}{mm}',
                #     foreground=colors[2],
                #     font="JetBrains Mono Bold",
                #     fontsize=13,
                #     update_interval=5,
                # ),


                # widget.Image(
                # filename='~/.config/qtile/Assets/Drop2.png',
                # ),



                widget.Image(
                    filename='~/.config/qtile/Assets/2.png',
                ),


                widget.Spacer(
                    length=8,
                    background=colors[5],
                ),


                widget.BatteryIcon(
                    theme_path='~/.config/qtile/Assets/Battery/',
                    background=colors[5],
                    scale=1,
                ),


                widget.Battery(
                    font='JetBrains Mono Bold',
                    background=colors[5],
                    foreground=colors[2],
                    format='{percent:2.0%}',
                    fontsize=13,
                ),


                # widget.Image(
                #     filename='~/.config/qtile/Assets/2.png',
                # ),


                # widget.Spacer(
                #     length=8,
                #     background=colors[5],
                # ),


                # widget.Battery(format=' {percent:2.0%}',
                #     font="JetBrains Mono ExtraBold",
                #     fontsize=12,
                #     padding=10,
                #     background=colors[5],
                # ),

                # widget.Memory(format='󰘚{MemUsed: .0f}{mm}',
                    # font="JetBrains Mono Bold",
                    # fontsize=12,
                    # padding=10,
                    # background='#4B4D66',
                # ),

                # widget.Volume(
                #     font='JetBrainsMono Nerd Font',
                #     theme_path='~/.config/qtile/Assets/Volume/',
                #     emoji=True,
                #     fontsize=13,
                #     background=colors[5],
                # ),


                # widget.Spacer(
                #     length=-5,
                #     background=colors[5],
                #     ),


                # widget.Volume(
                #     font='JetBrains Mono Bold',
                #     background=colors[5],
                #     foreground=colors[2],
                #     fontsize=13,
                # ),


                widget.Image(
                    filename='~/.config/qtile/Assets/5.png',
                    background=colors[5],
                ),


                widget.Image(
                    filename='~/.config/qtile/Assets/Misc/clock.png',
                    background=colors[1],
                    margin_y=6,
                    margin_x=5,
                ),


                widget.Clock(
                    format='%I:%M %p',
                    background=colors[1],
                    foreground=colors[2],
                    font="JetBrains Mono Bold",
                    fontsize=13,
                ),


                widget.Spacer(
                    length=18,
                    background=colors[1],
                ),



            ],
            30,
            border_color = colors[1],
            border_width = [0,0,0,0],
            margin = [15,30,6,30],

        ),
    ),
]