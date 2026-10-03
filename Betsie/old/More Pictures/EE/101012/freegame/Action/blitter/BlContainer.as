package blitter
{
    import __AS3__.vec.*;
    import flash.display.*;

    public class BlContainer extends BlObject
    {
        protected var content:Array;
        public var target:BlObject;

        public function BlContainer()
        {
            this.content = [];
            return;
        }// end function

        public function add(param1:BlObject) : BlObject
        {
            this.content.push(param1);
            return param1;
        }// end function

        public function addAt(param1:BlObject, param2:int) : BlObject
        {
            this.content.splice(param2, 0, param1);
            return param1;
        }// end function

        public function addBefore(param1:BlObject, param2:BlObject) : BlObject
        {
            var _loc_3:int = 0;
            while (_loc_3 < this.content.length)
            {
                
                if (this.content[_loc_3] == param2)
                {
                    return this.addAt(param1, _loc_3);
                }
                _loc_3++;
            }
            return this.add(param1);
        }// end function

        public function remove(param1:BlObject) : BlObject
        {
            var _loc_2:int = 0;
            while (_loc_2 < this.content.length)
            {
                
                if (this.content[_loc_2] === param1)
                {
                    this.content.splice(_loc_2, 1);
                    break;
                }
                _loc_2++;
            }
            return param1;
        }// end function

        public function removeAll() : void
        {
            this.content = [];
            return;
        }// end function

        public function get children() : Vector.<BlObject>
        {
            var _loc_1:* = new Vector.<BlObject>;
            var _loc_2:int = 0;
            while (_loc_2 < this.content.length)
            {
                
                _loc_1[_loc_2] = this.content[_loc_2];
                _loc_2++;
            }
            return _loc_1;
        }// end function

        public function offset(param1:int, param2:int) : void
        {
            this.x = this.x + param1;
            this.y = this.y + param2;
            return;
        }// end function

        override public function tick() : void
        {
            var _loc_1:BlObject = null;
            for each (_loc_1 in this.content)
            {
                
                _loc_1.tick();
            }
            super.tick();
            if (this.target != null)
            {
                this.x = this.x - (this.x - (-this.target.x + Bl.width / 2)) * Config.camera_lag;
                this.y = this.y - (this.y - (-this.target.y + Bl.height / 2)) * Config.camera_lag;
            }
            return;
        }// end function

        override public function exitFrame() : void
        {
            var _loc_1:BlObject = null;
            for each (_loc_1 in this.content)
            {
                
                _loc_1.exitFrame();
            }
            return;
        }// end function

        override public function enterFrame() : void
        {
            var _loc_1:BlObject = null;
            for each (_loc_1 in this.content)
            {
                
                _loc_1.enterFrame();
            }
            return;
        }// end function

        override public function draw(param1:BitmapData, param2:int, param3:int) : void
        {
            var _loc_4:BlObject = null;
            for each (_loc_4 in this.content)
            {
                
                _loc_4.draw(param1, param2 + x, param3 + y);
            }
            return;
        }// end function

    }
}
