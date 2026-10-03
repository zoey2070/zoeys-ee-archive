package items
{

    public class ItemId extends Object
    {
        public static const WAVE:int = 300;
        public static const SPEED_LEFT:int = 114;
        public static const SPEED_RIGHT:int = 115;
        public static const SPEED_UP:int = 116;
        public static const SPEED_DOWN:int = 117;
        public static const CHAIN:int = 118;
        public static const WATER:int = 119;
        public static const NINJA_LADDER:int = 120;
        public static const BRICK_COMPLETE:int = 121;
        public static const TIMEDOOR:int = 156;
        public static const TIMEGATE:int = 157;
        public static const COINDOOR:int = 43;
        public static const COINGATE:int = 165;
        public static const DIAMOND:int = 241;
        public static const CAKE:int = 337;

        public function ItemId()
        {
            return;
        }// end function

        public static function isSolid(param1:int) : Boolean
        {
            return param1 >= 9 && param1 <= 99 || param1 >= 122 && param1 <= 217;
        }// end function

    }
}
