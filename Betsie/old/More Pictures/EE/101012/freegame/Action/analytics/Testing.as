package analytics
{

    public class Testing extends Object
    {
        public static const TESTNAME:String = "frontpage_12_09";
        public static const SCENARIOS:Array = ["old", "new"];
        private static const ONLY_FOR_NEWUSERS:Boolean = true;
        private static const DEFAULT_FOR_EXISTING:int = 0;
        public static var isFirstLogin:Boolean = false;
        private static var scenario:int = -1;

        public function Testing()
        {
            return;
        }// end function

        public static function reset() : void
        {
            isFirstLogin = false;
            scenario = -1;
            return;
        }// end function

        public static function getTestName() : String
        {
            return TESTNAME;
        }// end function

        public static function isScenarioA() : Boolean
        {
            return !Boolean(getScenario());
        }// end function

        public static function getScenario() : int
        {
            var _loc_1:String = null;
            var _loc_2:String = null;
            if (Global.sharedCookie == null)
            {
                throw new Error("Cookie not loaded before testing started");
            }
            if (scenario < 0)
            {
                _loc_1 = Global.playerObject != null ? (Global.playerObject.name) : ("");
                _loc_2 = _loc_1 + "_abtest_" + TESTNAME;
                if (Global.sharedCookie.data[_loc_2] != null)
                {
                    scenario = Global.sharedCookie.data[_loc_2];
                }
                else
                {
                    if (ONLY_FOR_NEWUSERS && !Testing.isFirstLogin)
                    {
                        scenario = DEFAULT_FOR_EXISTING;
                    }
                    else
                    {
                        scenario = getRandom();
                        trackScenario();
                    }
                    Global.sharedCookie.data[_loc_2] = scenario;
                }
            }
            return scenario;
        }// end function

        public static function getScenarioName() : String
        {
            return SCENARIOS[getScenario()];
        }// end function

        public static function trackScenario() : void
        {
            if (Global.tracker != null)
            {
                Global.tracker.trackUserEvent("abtest", getTestName(), getScenario(), getScenarioName());
            }
            return;
        }// end function

        private static function getRandom() : int
        {
            return Math.round(Math.random());
        }// end function

    }
}
