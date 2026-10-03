package input
{
    import flash.display.*;
    import flash.events.*;

    public class KeyState extends Object
    {
        private static var stage:Stage;
        private static var key:Object;

        public function KeyState()
        {
            return;
        }// end function

        public static function activate(param1:Stage) : void
        {
            stage = param1;
            key = {};
            stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKey, false, 0, true);
            stage.addEventListener(KeyboardEvent.KEY_UP, handleKey, false, 0, true);
            stage.addEventListener(Event.DEACTIVATE, handleDeactivate, false, 0, true);
            return;
        }// end function

        static function handleDeactivate(event:Event) : void
        {
            key = {};
            return;
        }// end function

        public static function deactivate() : void
        {
            try
            {
                stage.removeEventListener(KeyboardEvent.KEY_DOWN, handleKey);
                stage.removeEventListener(KeyboardEvent.KEY_UP, handleKey);
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        private static function handleKey(event:KeyboardEvent) : void
        {
            key[event.keyCode] = event.type == KeyboardEvent.KEY_DOWN;
            return;
        }// end function

        public static function isKeyDown(param1:uint) : Boolean
        {
            return key[param1] != null && key[param1];
        }// end function

    }
}
