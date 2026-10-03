package 
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class WorldsFilter extends MovieClip
    {
        public var filter:TextField;

        public function WorldsFilter(param1:Function)
        {
            var callback:* = param1;
            this.filter.addEventListener(KeyboardEvent.KEY_UP, function (event:Event)
            {
                callback(filter.text);
                return;
            }// end function
            );
            return;
        }// end function

    }
}
