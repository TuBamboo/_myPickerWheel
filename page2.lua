local composer = require("composer")
local widget = require( "widget" )

local scene = composer.newScene()

function scene:create(event)

	local screenGroup = self.view
	
	local function goRegister( event )
    	if ( "ended" == event.phase ) then
    		composer.gotoScene("page1")  
    	end
    end
    	
	
	local btn_go1 = widget.newButton(
    	{
   	     	label = "Go Page 1",
   	     	fontSize = _W*50/1000,
   	     	labelColor = { default={ 1, 1, 1 }, over={ 1,1,1, 0.5 } },
   	     	shape="rect",
   	 		
    		fillColor = { default={ 39/255,110/255,146/255 ,0 }, over={ 39/255,110/255,146/255 ,0 } },
   	     	onEvent = goRegister
    	}
	)
	btn_go1.x=_W/2
	btn_go1.y=_H*9.3/10
    screenGroup:insert( btn_go1 )
	

end ------------- create end




function scene:show( event )
	if ( event.phase == "did" ) then
	end
end

function scene:hide( event )
	if ( event.phase == "did" ) then
	end
end



scene:addEventListener("create",scene)
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )


return scene




