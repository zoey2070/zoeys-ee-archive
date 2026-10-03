package ui
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.ui.*;
    import items.*;
    import ui2.*;

    public class BrickContainer extends ui2levelbrickscontainer
    {
        private var images:Array;
        private var sprites:Array;
        private var defaults:Vector.<ItemBrick>;
        private var selected:int = 0;
        private var selectedIndex:int = 0;
        private var uix:UI2;
        private var dragmc:Sprite;
        private var dragbm:Bitmap;
        private var indrag:Boolean = false;
        private var dragged:ItemBrick;
        private var oldvar:int = 0;

        public function BrickContainer(param1:Vector.<ItemBrick>, param2:UI2)
        {
            var _loc_4:BitmapData = null;
            var _loc_5:Bitmap = null;
            var _loc_6:Sprite = null;
            this.images = [];
            this.sprites = [];
            this.dragmc = new Sprite();
            this.dragbm = new Bitmap(new BitmapData(16, 16, false, 0));
            this.uix = param2;
            this.defaults = param1.concat();
            this.dragmc.addChild(this.dragbm);
            this.dragmc.mouseChildren = false;
            this.dragmc.mouseEnabled = false;
            this.dragmc.filters = [new DropShadowFilter(0, 45, 0, 1, 4, 4, 1, 3)];
            var _loc_7:Boolean = false;
            numbers.mouseEnabled = false;
            selector.mouseEnabled = _loc_7;
            var _loc_3:int = 0;
            while (_loc_3 < 11)
            {
                
                _loc_4 = new BitmapData(16, 16, false, 0);
                _loc_5 = new Bitmap(_loc_4);
                _loc_6 = new Sprite();
                this.attachClickHandler(_loc_6, _loc_3);
                _loc_6.useHandCursor = true;
                _loc_6.buttonMode = true;
                _loc_6.addChild(_loc_5);
                _loc_6.x = _loc_3 * 16;
                brickcontainer.addChild(_loc_6);
                this.images.push(_loc_4);
                this.sprites.push(_loc_6);
                _loc_3++;
            }
            _loc_3 = 0;
            while (_loc_3 < param1.length)
            {
                
                this.setDefault(_loc_3, param1[_loc_3]);
                _loc_3++;
            }
            addEventListener(Event.ADDED_TO_STAGE, this.handleAttach);
            addEventListener(Event.REMOVED_FROM_STAGE, this.handleDetatch);
            return;
        }// end function

        public function get value() : int
        {
            return this.selected;
        }// end function

        public function setDefault(param1:int, param2:ItemBrick) : void
        {
            this.defaults[param1] = param2;
            this.drawDefault(param1, param2);
            this.setSelected(param2.id);
            return;
        }// end function

        public function setDefaults(param1:Vector.<ItemBrick>) : void
        {
            this.defaults = param1.concat();
            var _loc_2:int = 0;
            while (_loc_2 < 11)
            {
                
                this.drawDefault(_loc_2, this.defaults[_loc_2]);
                _loc_2++;
            }
            return;
        }// end function

        public function select(param1:int, param2:Boolean = false) : void
        {
            this.selectedIndex = param1;
            this.selected = this.defaults[param1].id;
            selector.x = 3 + param1 * 16;
            selector.y = 10;
            selector.visible = true;
            if (!param2)
            {
                this.uix.setSelected(this.selected);
            }
            return;
        }// end function

        public function setSelected(param1:int) : void
        {
            var _loc_2:int = 0;
            while (_loc_2 < this.defaults.length)
            {
                
                if (this.defaults[_loc_2].id == param1)
                {
                    this.select(_loc_2, true);
                    return;
                }
                _loc_2++;
            }
            selector.visible = false;
            return;
        }// end function

        public function dragIt(param1:ItemBrick) : void
        {
            this.dragged = param1;
            this.indrag = true;
            stage.addEventListener(MouseEvent.MOUSE_UP, this.handleMouseUp);
            stage.addEventListener(MouseEvent.MOUSE_MOVE, this.handleMouseMove);
            this.dragbm.bitmapData.fillRect(this.dragbm.bitmapData.rect, 0);
            param1.drawTo(this.dragbm.bitmapData, 0, 0);
            this.dragmc.x = -1000;
            this.dragmc.y = -1000;
            return;
        }// end function

        private function handleMouseMove(event:MouseEvent = null) : void
        {
            stage.addChild(this.dragmc);
            this.dragmc.x = stage.mouseX - 8;
            this.dragmc.y = stage.mouseY - 8;
            if (event)
            {
                event.updateAfterEvent();
            }
            Mouse.hide();
            return;
        }// end function

        private function handleMouseUp(event:MouseEvent) : void
        {
            var _loc_2:int = 0;
            var _loc_3:Sprite = null;
            Mouse.show();
            if (this.indrag)
            {
                if (this.dragmc.parent)
                {
                    stage.removeChild(this.dragmc);
                }
                this.indrag = false;
                stage.removeEventListener(MouseEvent.MOUSE_UP, this.handleMouseUp);
                stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.handleMouseMove);
                _loc_2 = 0;
                while (_loc_2 < this.sprites.length)
                {
                    
                    _loc_3 = this.sprites[_loc_2] as Sprite;
                    if (_loc_3.hitTestPoint(this.dragmc.x + 8, this.dragmc.y + 8))
                    {
                        if (_loc_2 != 0)
                        {
                            this.setDefault(_loc_2, this.dragged);
                            this.setSelected(this.dragged.id);
                        }
                        return;
                    }
                    _loc_2++;
                }
            }
            return;
        }// end function

        private function handleAttach(event:Event) : void
        {
            stage.addEventListener(KeyboardEvent.KEY_DOWN, this.handleKeyDown);
            stage.addEventListener(KeyboardEvent.KEY_UP, this.handleKeyUp);
            return;
        }// end function

        private function handleDetatch(event:Event) : void
        {
            stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.handleKeyDown);
            stage.addEventListener(KeyboardEvent.KEY_UP, this.handleKeyUp);
            return;
        }// end function

        private function handleKeyDown(event:KeyboardEvent) : void
        {
            switch(event.keyCode)
            {
                case 16:
                case 17:
                {
                    if (this.selectedIndex != 0)
                    {
                        var _loc_2:* = this.selectedIndex;
                        this.oldvar = this.selectedIndex;
                    }
                    this.select(0);
                    break;
                }
                case 49:
                {
                    break;
                }
                case 50:
                {
                    break;
                }
                case 51:
                {
                    break;
                }
                case 52:
                {
                    break;
                }
                case 53:
                {
                    break;
                }
                case 54:
                {
                    break;
                }
                case 55:
                {
                    break;
                }
                case 56:
                {
                    break;
                }
                case 57:
                {
                    break;
                }
                case 48:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function handleKeyUp(event:KeyboardEvent) : void
        {
            if (this.oldvar != 0 && (event.keyCode == 16 || event.keyCode == 17))
            {
                this.select(this.oldvar);
            }
            return;
        }// end function

        private function attachClickHandler(param1:Sprite, param2:int) : void
        {
            var o:* = param1;
            var offset:* = param2;
            o.addEventListener(MouseEvent.MOUSE_DOWN, function () : void
            {
                select(offset);
                return;
            }// end function
            );
            return;
        }// end function

        private function drawDefault(param1:int, param2:ItemBrick) : void
        {
            BitmapData(this.images[param1]).fillRect(new Rectangle(0, 0, 16, 16), 4278190080);
            param2.drawTo(this.images[param1], 0, 0);
            return;
        }// end function

    }
}
