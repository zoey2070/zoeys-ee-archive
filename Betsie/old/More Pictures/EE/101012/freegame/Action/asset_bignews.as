package 
{
    import flash.display.*;
    import flash.text.*;

    dynamic public class asset_bignews extends MovieClip
    {
        public var btn_close:ProfileCloseButton;
        public var tf_header:TextField;
        public var imageloader:MovieClip;
        public var btnreadblog:SimpleButton;
        public var btnreadnewsletter:SimpleButton;
        public var newsletter_name:TextField;
        public var tf_date:TextField;
        public var bg:MovieClip;
        public var newsletter_email:TextField;
        public var tf_body:TextField;
        public var fbsharebtn:SimpleButton;

        public function asset_bignews()
        {
            addFrameScript(0, this.frame1);
            return;
        }// end function

        function frame1()
        {
            stop();
            return;
        }// end function

    }
}
