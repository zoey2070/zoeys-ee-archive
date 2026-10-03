package ui.ingame
{
    import playerio.*;

    public class PotionCounter extends Object
    {
        private var potioncount:Object;

        public function PotionCounter()
        {
            return;
        }// end function

        public function deserializeFromMessage(param1:Message) : void
        {
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            var _loc_5:int = 0;
            var _loc_6:int = 0;
            var _loc_4:int = 0;
            while (_loc_4 < param1.length)
            {
                
                try
                {
                    if (param1.getString(_loc_4) == "ps")
                    {
                        _loc_2 = _loc_4 + 1;
                    }
                    if (param1.getString(_loc_4) == "pe")
                    {
                        _loc_3 = _loc_4;
                    }
                }
                catch (e:Error)
                {
                }
                _loc_4++;
            }
            this.potioncount = {};
            while (_loc_2 < _loc_3)
            {
                
                _loc_5 = param1.getInt(_loc_2++);
                _loc_6 = param1.getInt(_loc_2++);
                this.potioncount[_loc_5] = _loc_6;
            }
            return;
        }// end function

        public function getCount(param1:int) : int
        {
            return this.potioncount[param1] != null ? (this.potioncount[param1]) : (0);
        }// end function

    }
}
