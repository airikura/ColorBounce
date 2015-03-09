			local composer = require( "composer" )
			local options =
{
    effect = "fade",
    time = 400,
    params =
    {
    }
}
			display.setDefault( "background", 1, .9921568627, .8156862745)
			composer.gotoScene( "scene2" , options);
