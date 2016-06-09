local _myPickerWheel = {}

local _defaultMyPickerWheel={}


function _myPickerWheel.newPickerWheel(event) 

	local _t=_defaultMyPickerWheel(event)
	
	
	local pickerGroup = display.newGroup()
	local pickerGroup_scroll_1 = display.newGroup()
	
	
	local selectValue=""
	local draging=0
	local startX=0 -- to cancel click
	local startY=0 -- to cancel click
	local scrolled=0 --  to cancel click
	local scroll_Speed = 0 -- scroll speed
	local scroll_touchY_1 = 0 -- scroll locate
	local scrolling=-1 -- 1 ing , -1 fixed
	local _fixed = 0 -- scroll y fixed
	
	local limit_up=0
	local limit_down=(#_t.labels-1) * _t.height/5
	
	print("limit_down : " .. limit_down)
	
	local table_text={}
	
	local temp_speed={}
	for i=1,5 do
		table.insert( temp_speed , 0 )
	end
	
	
	local BG = display.newRect(0,0,_t.width,_t.height)
	local BG_R , BG_G , BG_B , BG_A=unpack(_t.columnColor )
	BG:setFillColor( BG_R , BG_G , BG_B , BG_A)
	if BG_A==0 then
		BG:setFillColor( BG_R , BG_G , BG_B , 0.01)
	end
	pickerGroup:insert( BG )
	
	local gradientR , gradientG , gradientB = unpack( _t.columnColor,1,3 )
	
	local gradientRect_1 = display.newRect( 0, 0, _t.width, _t.height/5 )
	gradientRect_1.y=-_t.height/5*2
	local gradient_1 = {
    	type="gradient",
    	color1={unpack( _t.columnColor)}, color2={ gradientR , gradientG , gradientB , 0 }, direction="down"
	}
	gradientRect_1:setFillColor( gradient_1 )
	
	local gradientRect_2 = display.newRect( 0, 0, _t.width, _t.height/5 )
	gradientRect_2.y=_t.height/5*2
	local gradient_2 = {
    	type="gradient",
    	color1={unpack( _t.columnColor)}, color2={ gradientR , gradientG , gradientB , 0 }, direction="up"
	}
	gradientRect_2:setFillColor( gradient_2 )
	
	
	
	
	local color_default=function()
		for i=1,#table_text do
			table_text[i]:setFillColor( unpack(_t.fontColor ))
		end
	end
	
	
	print(_t.fontColor)
	
	local fix_to_y =function(event)
		selectValue=event.text
		_fixed=1
--		transition.cancel( "transTag" )
		event:setFillColor(unpack(_t.fontColorSelected))
		transition.to( pickerGroup_scroll_1, { time=300,y=-event.y, transition=easing.outCubic , tag="transTag"} )
	end
	
	
	for i=1,#_t.labels do
		local textBG = display.newRect(0,0,_t.width,_t.height/5)
		textBG:setFillColor(0,1,0,0.5)
		textBG.y=_t.height/5*(i-1)
		textBG.alpha=0.01
		pickerGroup_scroll_1:insert(textBG)
		
		local text = display.newText( "Hello World! " .. i, 0, 0, _t.font, _t.fontSize )
		text:setFillColor( unpack(_t.fontColor ))
		text.y=_t.height/5*(i-1)
		text.text=_t.labels[i]
		pickerGroup_scroll_1:insert( text )
		
		if _t.align=="right" then
			text.anchorX=1
			text.x=_t.width/2
		elseif _t.align=="left" then
			text.anchorX=0
			text.x=-_t.width/2
		end
		
		table.insert( table_text , text )
		
		local text_listener=function(event)
--			print("textBG.y : " .. textBG.y)
			if event.phase =="ended" and textBG.y>-pickerGroup_scroll_1.y-BG.height/2 and textBG.y<-pickerGroup_scroll_1.y+BG.height/2 and scrolled==0 then
				fix_to_y(table_text[i])
			end
		end
		textBG:addEventListener("touch",text_listener)
	end
	
	pickerGroup:insert( pickerGroup_scroll_1 )
	pickerGroup:insert( gradientRect_1 )
	pickerGroup:insert( gradientRect_2 )
	
	fix_to_y(table_text[event.startIndex])
	
	
			
			local myMask = graphics.newMask( "_myMask.png" )
			pickerGroup:setMask( myMask )
			
			local _mask_W=200
			local _mask_H=200
			
			pickerGroup.maskScaleX, pickerGroup.maskScaleY = _t.width/_mask_W , _t.height/_mask_H
	
	
	
	local BG_listener=function(event)
		if event.phase =="began" then
			for i=1,5 do
				table.insert( temp_speed , pickerGroup_scroll_1.y )
				table.remove( temp_speed , 1 )
			end
			transition.cancel( "transTag" )
			startX=event.x
			startY=event.y
			color_default()
			_fixed=0
			draging=1
			scrolled=0
			scroll_touchY_1=-pickerGroup_scroll_1.y-pickerGroup.y+(event.y*math.cos(_t.rotation/(180/math.pi))-event.x*math.sin(_t.rotation/(180/math.pi)))
--			print("pickerGroup_scroll_1.y : " .. pickerGroup_scroll_1.y)
--			print("scroll_touchY_1.y : " .. scroll_touchY_1)
		elseif event.phase =="moved" then
			if math.abs(event.y - startY)+math.abs(event.x - startX) > BG.height/20 then
				scrolled=1
			end
		elseif event.phase =="ended" or event.phase == "cancelled" then
--			scroll_Speed = (startY - event.y)
		end
	end
	BG:addEventListener("touch",BG_listener)
	

	
	local Runtime_listener=function(event)
		if event.phase =="moved" and draging==1 then -- drag scroll
--			print("pickerGroup_scroll_1.y : " .. pickerGroup_scroll_1.y)
			pickerGroup_scroll_1.y=(event.y*math.cos(_t.rotation/(180/math.pi))-event.x*math.sin(_t.rotation/(180/math.pi)))-pickerGroup.y-scroll_touchY_1
		elseif event.phase =="ended" or event.phase == "cancelled" then -- cancel scroll
			draging=0
		end
	end
	Runtime:addEventListener("touch",Runtime_listener)
	
--	scroll_Speed=20
	
	local myListener={}
	myListener = function( event )
--		print(event.name)
		if BG.x then
			
			if math.abs(scroll_Speed) > _t.height/100 and draging==0 and scrolled==1 and _fixed==0 then -- auto scroll
				pickerGroup_scroll_1.y=pickerGroup_scroll_1.y-scroll_Speed
 				scroll_Speed=scroll_Speed*19/20
 				if pickerGroup_scroll_1.y<-limit_down or pickerGroup_scroll_1.y>limit_up then
 					scroll_Speed=scroll_Speed*1/2
 				end
			elseif draging==0 and scrolled==1 and _fixed==0 then
				local goItem=(-pickerGroup_scroll_1.y)/(_t.height/5)
				goItem=goItem+1.5
				goItem=goItem-goItem%1
				if goItem<1 then
					goItem=1
				end
				if goItem>#_t.labels then
					goItem=#_t.labels
				end
				fix_to_y(table_text[goItem])
			end
			
			
			
			if draging==1 then -- speed
				table.insert( temp_speed , pickerGroup_scroll_1.y )
				table.remove( temp_speed , 1 )
				scroll_Speed = (temp_speed[1] - pickerGroup_scroll_1.y)/2
  			end

    	else
    		Runtime:removeEventListener("touch",Runtime_listener)
    		Runtime:removeEventListener( "enterFrame", myListener )
    	end
	end
	Runtime:addEventListener( "enterFrame", myListener )
	
	
	function pickerGroup:getValue()
		return selectValue
	end	
	
	pickerGroup.rotation=_t.rotation
	
	return pickerGroup
end



_defaultMyPickerWheel=function(event)

	if event.width==nil then event.width=200 end -- width default 100
	if event.height==nil then event.height=200 end -- height default 100
	if event.fontSize==nil then event.fontSize=20 end -- fontSize default 20
	if event.align==nil then event.align="center" end -- align default center
	if event.startIndex==nil then event.startIndex=1 end -- startIndex default 1
	if event.font==nil then event.font=nil end -- font default nil
	if event.fontColor==nil then event.fontColor={0.5,0.5,0.5,1} end -- fontColor default 0.5
	if event.fontColorSelected==nil then event.fontColorSelected={1,1,1,1} end -- fontColorSelected default 1
	if event.columnColor==nil then event.columnColor={0,0,0,1} end -- columnColor default 0
	if event.rotation==nil then event.rotation=0 end -- rotation default 0
	
	
	
	return event
end




return _myPickerWheel
















