package 
{

    public class Config extends Object
    {
        public static const playerio_game_id:String = "everybody-edits-su9rn58o40itdbnw69plyw";
        public static const server_type_version:int = 129;
        public static const server_type_normalroom:String = "Everybodyedits" + server_type_version;
        public static const server_type_betaroom:String = "Beta" + server_type_version;
        public static const server_type_guestserviceroom:String = "LobbyGuest" + server_type_version;
        public static const server_type_serviceroom:String = "Lobby" + server_type_version;
        public static const server_type_authroom:String = "Auth" + server_type_version;
        public static const server_type_blacklistroom:String = "QuickInviteHandler" + server_type_version;
        public static const server_type_tutorialroom:String = "Tutorial" + server_type_version + "_world_";
        public static const server_type_trackingroom:String = "Tracking" + server_type_version;
        public static const use_debug_server:Boolean = false;
        public static const run_in_development_mode:Boolean = false;
        public static const show_disabled_shopitems:Boolean = false;
        public static const development_mode_autojoin_room:String = "PWqxB8WAGWbEI";
        public static const developer_server:String = "127.0.0.1:8184";
        public static const forceArmor:Boolean = false;
        public static const armor_userid:String = null;
        public static const armor_authtoken:String = null;
        public static const forceBeta:Boolean = false;
        public static const show_debug_profile:Boolean = false;
        public static const debug_profile:String = "mrshoe";
        public static const disableCookie:Boolean = false;
        public static const show_debug_friendrequest:Boolean = false;
        public static const debug_friendrequest:String = "";
        public static const show_blacklist_invitation:Boolean = false;
        public static const debug_invitation:String = "";
        public static var physics_ms_per_tick:int = 10;
        public static var physics_variable_multiplyer:Number = 7.752;
        public static var physics_base_drag:Number = Math.pow(0.9981, physics_ms_per_tick) * 1.00016;
        public static var physics_no_modifier_drag:Number = Math.pow(0.99, physics_ms_per_tick) * 1.00016;
        public static var physics_water_drag:Number = Math.pow(0.995, physics_ms_per_tick) * 1.00016;
        public static var physics_jump_height:Number = 26;
        public static var physics_gravity:Number = 2;
        public static var physics_boost:Number = 16;
        public static var physics_water_buoyancy:Number = -0.5;
        public static var physics_queue_length:int = 2;
        public static var shop_potion_max:int = 10;
        public static var camera_lag:Number = 0.0625;
        public static var isMobile:Boolean = false;
        public static var enableDebugShadow:Boolean = false;
        public static const maxwidth:int = 850;
        public static const minwidth:int = 640;
        public static const width:int = 640;
        public static const height:int = 500;
        public static const maxFrameRate:int = 120;
        public static const guest_color:uint = 3355443;
        public static const default_color:uint = 15658734;
        public static const default_color_dark:uint = 13421772;
        public static const friend_color:uint = 65280;
        public static const friend_color_dark:uint = 47872;
        public static const mod_color:uint = 16759552;
        public static const admin_color:uint = 16757760;
        public static const tutorial_names:Array = ["Moving", "Gravity", "Edit"];
        public static const debug_news:String = "";
        public static const disable_tracking:Boolean = false;

        public function Config()
        {
            return;
        }// end function

    }
}
