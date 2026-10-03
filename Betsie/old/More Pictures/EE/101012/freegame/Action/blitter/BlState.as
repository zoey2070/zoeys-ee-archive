package blitter
{

    public class BlState extends BlContainer
    {
        public var stopRendering:Boolean = false;
        public static const STATE_ALIGN_LEFT:String = "left";
        public static const STATE_ALIGN_CENTER:String = "center";
        public static const STATE_ALIGN_RIGHT:String = "right";

        public function BlState()
        {
            return;
        }// end function

        public function resize() : void
        {
            return;
        }// end function

        public function get align() : String
        {
            return STATE_ALIGN_CENTER;
        }// end function

    }
}
