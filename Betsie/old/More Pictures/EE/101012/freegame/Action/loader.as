package 
{
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;

    public class loader extends MovieClip
    {

        public function loader()
        {
            var loader:preloader;
            loader = new preloader();
            loader.masker.scaleX = 0;
            loader.x = (stage.stageWidth - loader.width) / 2;
            loader.y = 180;
            addChild(loader);
            addEventListener(Event.ENTER_FRAME, function (event:Event) : void
            {
                arguments = null;
                if (stage.loaderInfo.bytesTotal != 0)
                {
                    loader.masker.scaleX = stage.loaderInfo.bytesLoaded / stage.loaderInfo.bytesTotal;
                    if (stage.loaderInfo.bytesLoaded == stage.loaderInfo.bytesTotal)
                    {
                        removeChild(loader);
                        nextFrame();
                        arguments = Class(getDefinitionByName("EverybodyEdits"));
                        addChild(new arguments);
                        removeEventListener(Event.ENTER_FRAME, arguments.callee);
                    }
                }
                return;
            }// end function
            );
            return;
        }// end function

    }
}
