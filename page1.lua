local composer = require("composer")
local widget = require( "widget" )

local _myPickerWheel = require ("_myPickerWheel")

local scene = composer.newScene()

function scene:create(event)

	local screenGroup = self.view
	
	
	local days = {}
	local years = {}
	for i = 1,31 do days[i] = i end
	for j = 1,47 do years[j] = 1969+j end

	
	
	local pickerWheel_1 = _myPickerWheel.newPickerWheel(
    	{
    		align = "center", -- left , center , right
        	startIndex = 5, 
    		labels = { "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" },
   	    	width = 100,
  	    	height = 200,
  	    	font=nil,
  	    	fontSize=18,
  	    	rotation=0,
  	    	columnColor = { 0, 0, 1, 0 },
  	    	fontColor = { 0.4, 0.4, 0.4, 0.5 },
        	fontColorSelected = { 1,0,0,1 }
    	}
	)
	
	pickerWheel_1.x=_W/2-75
	pickerWheel_1.y=_H/2
	screenGroup:insert(pickerWheel_1)
	
	
	
	
	local pickerWheel_2 = _myPickerWheel.newPickerWheel(
    	{
    		align = "center", -- left , center , right
        	startIndex =2,
    		labels = days,
   	    	width = 50,
  	    	height = 200,
  	    	fontSize=18,
    	}
	)
	pickerWheel_2.x=_W/2
	pickerWheel_2.y=_H/2
	screenGroup:insert(pickerWheel_2)
	
	local pickerWheel_3 = _myPickerWheel.newPickerWheel(
    	{
    		align = "center", -- left , center , right
        	startIndex =2,
    		labels = years,
   	    	width = 80,
  	    	height = 150,
  	    	fontSize=18,
    	}
	)
	pickerWheel_3.x=_W/2+65
	pickerWheel_3.y=_H/2
	screenGroup:insert(pickerWheel_3)
	
	
	
	
	
	
	
	local pickerWheel_4 = _myPickerWheel.newPickerWheel(
    	{
    		align = "center", -- left , center , right
        	startIndex = 5, 
    		labels = years,
   	    	width = 80,
  	    	height = 200,
  	    	font=nil,
  	    	fontSize=18,
  	    	rotation=270,
  	    	columnColor = { 0, 0, 1, 0 },
  	    	fontColor = { 0.4, 0.4, 0.4, 0.5 },
        	fontColorSelected = { 1,0,0,1 }
    	}
	)
	
	pickerWheel_4.x=_W/2
	pickerWheel_4.y=_H*7.5/10
	screenGroup:insert(pickerWheel_4)
	
	
	
	
	
	
	
	local myText = display.newText( "Hello World!", _W/2, _H*1.5/10 , native.systemFont, 20 )
	myText:setFillColor( 1 )
	screenGroup:insert(myText)
	
	
	
	local function getValue( event )
    	if ( "ended" == event.phase ) then
    		local myValue_1=pickerWheel_1:getValue() 
    		local myValue_2=pickerWheel_2:getValue()
    		local myValue_3=pickerWheel_3:getValue()
    		local myValue_4=pickerWheel_4:getValue() 
    		myText.text= "myValue_1 : " .. myValue_1 .. "\nmyValue_2 : " .. myValue_2 .. "\nmyValue_3 : " .. myValue_3 .. "\nmyValue_4 : " .. myValue_4
    	end
    end
    	
	
	local btn_get = widget.newButton(
    	{
   	     	label = "Get Value",
   	     	fontSize = _W*100/1000,
   	     	labelColor = { default={ 1, 1, 1 }, over={ 1,1,1, 0.5 } },
   	     	shape="rect",
   	 		
    		fillColor = { default={ 39/255,110/255,146/255 ,0 }, over={ 39/255,110/255,146/255 ,0 } },
   	     	onEvent = getValue
    	}
	)
	btn_get.x=_W/2
	btn_get.y=_H*8.5/10
    screenGroup:insert( btn_get )
	
	
	
	
	
	
	

	local function goRegister( event )
    	if ( "ended" == event.phase ) then
    		composer.gotoScene("page2")  
    	end
    end
    	
	
	local btn_go2 = widget.newButton(
    	{
   	     	label = "Go Page 2",
   	     	fontSize = _W*50/1000,
   	     	labelColor = { default={ 1, 1, 1 }, over={ 1,1,1, 0.5 } },
   	     	shape="rect",
   	 		
    		fillColor = { default={ 39/255,110/255,146/255 ,0 }, over={ 39/255,110/255,146/255 ,0 } },
   	     	onEvent = goRegister
    	}
	)
	btn_go2.x=_W/2
	btn_go2.y=_H*9.3/10
    screenGroup:insert( btn_go2 )
	
end ------------- create end




function scene:show( event )
	if ( event.phase == "did" ) then
	end
end

function scene:hide( event )
	if ( event.phase == "did" ) then
--		composer.removeScene( "page1" )
	end
end



scene:addEventListener("create",scene)
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )


return scene




