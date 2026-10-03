package ui
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import items.*;
    import ui2.*;

    public class BrickPackage extends ui2brickpackage
    {
        private var sp:Sprite;
        private var content:Vector.<ItemBrick>;
        private var uix:UI2;
        private var highlight:Bitmap;
        private var val:int = 0;

        public function BrickPackage(param1:String, param2:Vector.<ItemBrick>, param3:UI2)
        {
            var _loc_4:TextField = null;
            var _loc_8:ItemBrick = null;
            var _loc_9:int = 0;
            this.sp = new Sprite();
            this.content = new Vector.<ItemBrick>;
            this.highlight = new Bitmap(new ui2selector());
            this.content = param2;
            this.uix = param3;
            _loc_4 = new TextField();
            _loc_4.embedFonts = true;
            _loc_4.selectable = false;
            _loc_4.antiAliasType = AntiAliasType.ADVANCED;
            _loc_4.mouseEnabled = false;
            _loc_4.defaultTextFormat = new TextFormat("visitor", 13, 16777215);
            _loc_4.text = param1;
            _loc_4.width = _loc_4.textWidth + 5;
            _loc_4.height = _loc_4.textHeight + 5;
            addChild(_loc_4);
            var _loc_5:* = new BitmapData(param2.length * 16, 16, false, 4294967295);
            var _loc_6:* = new Bitmap(_loc_5);
            this.sp.addChild(_loc_6);
            this.sp.y = 12;
            this.sp.x = 2;
            addChild(this.sp);
            var _loc_7:int = 0;
            while (_loc_7 < param2.length)
            {
                
                _loc_8 = param2[_loc_7];
                switch(_loc_8.id)
                {
                    case 282:
                    case 283:
                    case 284:
                    {
                        _loc_9 = 565;
                        break;
                    }
                    default:
                    {
                        _loc_9 = 0;
                        break;
                        break;
                    }
                }
                ItemManager.bricks[_loc_9].drawTo(_loc_5, _loc_7 * 16, 0);
                _loc_8.drawTo(_loc_5, _loc_7 * 16, 0);
                _loc_7++;
            }
            this.sp.useHandCursor = true;
            this.sp.buttonMode = true;
            this.sp.addEventListener(MouseEvent.MOUSE_DOWN, this.handleMouseDown);
            addChild(this.highlight);
            this.highlight.x = 2;
            this.highlight.y = 12;
            return;
        }// end function

        private function handleMouseDown(event:MouseEvent) : void
        {
            var _loc_2:* = this.sp.mouseX / 16 >> 0;
            if (_loc_2 >= this.content.length)
            {
                return;
            }
            this.select(_loc_2);
            this.uix.dragIt(this.content[_loc_2]);
            return;
        }// end function

        private function select(param1:int) : void
        {
            if (param1 >= this.content.length)
            {
                return;
            }
            this.uix.setSelected(this.content[param1].id);
            this.setSelected(this.content[param1].id);
            return;
        }// end function

        public function getPosition(param1:int) : Point
        {
            var _loc_2:int = 0;
            while (_loc_2 < this.content.length)
            {
                
                if (this.content[_loc_2].id == param1)
                {
                    return new Point(_loc_2 * 16 + 2 + x + 8, y + 8);
                }
                _loc_2++;
            }
            return null;
        }// end function

        public function setSelected(param1:int) : void
        {
            this.val = param1;
            var _loc_2:int = 0;
            while (_loc_2 < this.content.length)
            {
                
                if (this.content[_loc_2].id == param1)
                {
                    this.highlight.x = _loc_2 * 16 + 2;
                    this.highlight.visible = true;
                    return;
                }
                _loc_2++;
            }
            this.highlight.visible = false;
            return;
        }// end function

    }
}
