package com.google.analytics
{
    import com.google.analytics.debug.*;
    import com.google.analytics.v4.*;

    public interface AnalyticsTracker extends GoogleAnalyticsAPI, IEventDispatcher
    {

        public function AnalyticsTracker();

        function set config(param1:Configuration) : void;

        function isReady() : Boolean;

        function get mode() : String;

        function set debug(param1:DebugConfiguration) : void;

        function get account() : String;

        function set mode(param1:String) : void;

        function get config() : Configuration;

        function get debug() : DebugConfiguration;

        function set account(param1:String) : void;

        function get visualDebug() : Boolean;

        function set visualDebug(param1:Boolean) : void;

    }
}
