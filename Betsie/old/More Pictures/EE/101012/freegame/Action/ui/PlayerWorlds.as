package ui
{
    import playerio.*;

    public class PlayerWorlds extends Object
    {

        public function PlayerWorlds()
        {
            return;
        }// end function

        public static function addSavedWorlds(param1:Array, param2:Client, param3:Boolean, param4:Boolean) : void
        {
            var _loc_5:RoomInfo = null;
            if (Global.player_is_beta_member)
            {
                _loc_5 = findWorld(param1, Global.playerObject.room0);
                if (_loc_5 != null)
                {
                    _loc_5.data.myworld = true;
                }
                else
                {
                    param1.push({id:"savedworld", data:{name:"Beta Saved World", owned:true, needskey:true, myworld:true}});
                }
                if (param4)
                {
                    _loc_5 = findWorld(param1, Global.playerObject.betaonlyroom);
                    if (_loc_5 != null)
                    {
                        _loc_5.data.myworld = true;
                    }
                    else
                    {
                        param1.push({id:"savedbetaworld", data:{name:"Beta Only Saved World", beta:true, owned:true, needskey:true, myworld:true}});
                    }
                }
            }
            addWorlds(param1, "0", param2.payVault.count("world0") + (Global.player_is_beta_member ? (1) : (0)), "Small Saved World");
            addWorlds(param1, "1", param2.payVault.count("world1"), "Medium Saved World");
            addWorlds(param1, "2", param2.payVault.count("world2"), "Large Saved World");
            addWorlds(param1, "3", param2.payVault.count("world3"), "Massive Saved World");
            addWorlds(param1, "4", param2.payVault.count("world4"), "Wide Saved World");
            addWorlds(param1, "5", param2.payVault.count("world5"), "Great Saved World");
            addWorlds(param1, "6", param2.payVault.count("world6"), "Tall Saved World");
            addWorlds(param1, "7", param2.payVault.count("world7"), "Ultra Wide Saved World");
            addWorlds(param1, "8", param2.payVault.count("world8"), "Low Gravity World");
            return;
        }// end function

        private static function findWorld(param1:Array, param2:String) : RoomInfo
        {
            var _loc_3:int = 0;
            while (_loc_3 < param1.length)
            {
                
                if (param1[_loc_3].id == param2)
                {
                    return param1[_loc_3];
                }
                _loc_3++;
            }
            return null;
        }// end function

        private static function addWorlds(param1:Array, param2:String, param3:int, param4:String) : Array
        {
            var _loc_7:RoomInfo = null;
            var _loc_8:String = null;
            var _loc_9:Object = null;
            var _loc_5:Array = [];
            var _loc_6:int = 0;
            while (_loc_6 < param3)
            {
                
                _loc_7 = findWorld(param1, Global.playerObject.rooms["world" + param2 + "x" + _loc_6]);
                if (_loc_7)
                {
                    _loc_7.data.myworld = true;
                }
                else
                {
                    _loc_7 = findWorld(param1, param2 + "x" + _loc_6);
                    if (_loc_7 != null)
                    {
                    }
                    else
                    {
                        _loc_8 = Global.playerObject.roomnames["world" + param2 + "x" + _loc_6] || param4 + " " + (_loc_6 + 1);
                        _loc_9 = {id:param2 + "x" + _loc_6, data:{name:_loc_7 ? (_loc_7.data.name) : (_loc_8), owned:true, needskey:true, myworld:true}};
                        param1.push(_loc_9);
                        _loc_5.push(_loc_9);
                    }
                }
                _loc_6++;
            }
            return _loc_5;
        }// end function

    }
}
