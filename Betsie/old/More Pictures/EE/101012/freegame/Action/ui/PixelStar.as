package ui
{

    public class PixelStar extends asset_starpixels
    {
        public var max_dist:Number;
        public var speed:Number;
        public var speed_x:Number;
        public var speed_y:Number;

        public function PixelStar()
        {
            return;
        }// end function

        public function tick() : void
        {
            x = x + this.speed_x * this.speed;
            y = y + this.speed_y * this.speed;
            var _loc_1:* = Math.sqrt(Math.pow(x, 2) + Math.pow(y, 2));
            alpha = 1 - _loc_1 / 200;
            if (alpha <= 0 && parent != null)
            {
                parent.removeChild(this);
            }
            return;
        }// end function

    }
}
