package com.greensock.plugins
{
    import com.greensock.*;

    public class VisiblePlugin extends TweenPlugin
    {
        protected var _progress:int;
        protected var _target:Object;
        protected var _initVal:Boolean;
        protected var _visible:Boolean;
        protected var _tween:TweenLite;
        public static const API:Number = 1;

        public function VisiblePlugin()
        {
            this.propName = "visible";
            this.overwriteProps = ["visible"];
            return;
        }// end function

        override public function onInitTween(param1:Object, param2, param3:TweenLite) : Boolean
        {
            _target = param1;
            _tween = param3;
            _progress = _tween.vars.runBackwards ? (0) : (1);
            _initVal = _target.visible;
            _visible = Boolean(param2);
            return true;
        }// end function

        override public function set changeFactor(param1:Number) : void
        {
            _target.visible = (param1 == 1 || param1 == 0) && _tween.cachedTime / _tween.cachedDuration == _progress ? (_visible) : (_initVal);
            return;
        }// end function

    }
}
