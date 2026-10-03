package 
{
    import blitter.*;
    import flash.display.*;
    import flash.geom.*;

    public class MiniMap extends BlObject
    {
        private var bmd:BitmapData;
        private var playermap:BitmapData;

        public function MiniMap(param1:World, param2:int, param3:int)
        {
            this.bmd = new BitmapData(param2, param3, true, 0);
            this.playermap = new BitmapData(param2, param3, true, 0);
            this.x = 640 - param2 - 2;
            this.y = 470 - param3 - 2;
            this.reset(param1);
            return;
        }// end function

        public function updatePixel(param1:int, param2:int, param3:Number) : void
        {
            this.bmd.setPixel32(param1, param2, param3);
            return;
        }// end function

        public function showPlayer(param1:Player, param2:uint) : void
        {
            this.playermap.setPixel32(param1.x >> 4, param1.y >> 4, param2);
            return;
        }// end function

        public function clear() : void
        {
            this.playermap.colorTransform(this.playermap.rect, new ColorTransform(1, 1, 1, 1 - 1 / 64));
            return;
        }// end function

        public function reset(param1:World) : void
        {
            var _loc_3:int = 0;
            var _loc_2:int = 0;
            while (_loc_2 < param1.width)
            {
                
                _loc_3 = 0;
                while (_loc_3 < param1.height)
                {
                    
                    this.bmd.setPixel32(_loc_2, _loc_3, param1.getMinimapColor(_loc_2, _loc_3));
                    _loc_3++;
                }
                _loc_2++;
            }
            return;
        }// end function

        public function drawDirect(param1:BitmapData) : void
        {
            param1.copyPixels(this.bmd, this.bmd.rect, new Point(0, 0));
            return;
        }// end function

        override public function draw(param1:BitmapData, param2:int, param3:int) : void
        {
            param1.copyPixels(this.bmd, this.bmd.rect, new Point(x, y - (Bl.data.moreisvisible ? (Bl.data.bselector.height + 3) : (0))));
            param1.copyPixels(this.playermap, this.playermap.rect, new Point(x, y - (Bl.data.moreisvisible ? (Bl.data.bselector.height + 3) : (0))));
            this.clear();
            return;
        }// end function

    }
}
