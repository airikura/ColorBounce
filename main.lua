			local composer = require( "composer" )
			local options =
{
    effect = "fade",
    time = 400,
    params =
    {
    }
}
			--display.setDefault( "background", 1, .9921568627, .8156862745)
			display.setDefault( "background", 0.96078431372, 0.96078431372, 0.96078431372)
			--display.setDefault( "background", 0.33333333, 0.33333333, 0.3333333)
			composer.gotoScene( "scene2" , options);
