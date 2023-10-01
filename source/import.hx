import Paths;

import lib.*;
import misc.*;
import inputs.*;

import shaders.Types;
import shaders.*;

import funkin.Types;

import funkin.backend.*;
import funkin.utils.native.HiddenProcess;

#if windows
import funkin.utils.native.Windows;
#elseif mac
import funkin.utils.native.Mac;
#elseif linux
import funkin.utils.native.Linux;
#end

import funkin.hud.*;
import funkin.utils.*;
import funkin.objects.*;
import funkin.gameplay.*;
import funkin.framerate.*;

import funkin.ui.atlas.Types;
import funkin.ui.atlas.*;

import funkin.ui.menu.Types;
import funkin.ui.menu.*;

import funkin.ui.Types;

import funkin.ui.*;
import funkin.ui.text.*;
import funkin.ui.objects.*;
import funkin.ui.mainmenu.*;

import funkin.ui.menus.*;

import funkin.states.*;
import funkin.states.substates.*;