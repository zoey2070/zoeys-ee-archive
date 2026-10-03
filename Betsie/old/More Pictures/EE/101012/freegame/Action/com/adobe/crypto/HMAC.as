package com.adobe.crypto
{
    import flash.utils.*;

    public class HMAC extends Object
    {

        public function HMAC()
        {
            return;
        }// end function

        public static function hash(param1:String, param2:String, param3:Object = null) : String
        {
            var _loc_4:* = new ByteArray();
            var _loc_5:* = new ByteArray();
            _loc_4.writeUTFBytes(param2);
            _loc_5.writeUTFBytes(param1);
            return hashBytes(_loc_5, _loc_4, param3);
        }// end function

        public static function hashBytes(param1:ByteArray, param2:ByteArray, param3:Object = null) : String
        {
            var _loc_9:int = 0;
            var _loc_4:* = new ByteArray();
            var _loc_5:* = new ByteArray();
            var _loc_6:* = Endian.BIG_ENDIAN;
            if (param3 == null)
            {
                param3 = MD5;
            }
            if (describeType(param3).@name.toString() == "com.adobe.crypto::MD5")
            {
                _loc_6 = Endian.LITTLE_ENDIAN;
            }
            if (param1.length > 64)
            {
                param3.hashBytes(param1);
                param1 = new ByteArray();
                param1.endian = _loc_6;
                while (param3.digest.bytesAvailable != 0)
                {
                    
                    param1.writeInt(param3.digest.readInt());
                }
            }
            param1.length = 64;
            param1.position = 0;
            var _loc_7:int = 0;
            while (_loc_7 < 64)
            {
                
                _loc_9 = param1.readByte();
                _loc_4.writeByte(54 ^ _loc_9);
                _loc_5.writeByte(92 ^ _loc_9);
                _loc_7++;
            }
            _loc_4.writeBytes(param2);
            param3.hashBytes(_loc_4);
            var _loc_8:* = new ByteArray();
            new ByteArray().endian = _loc_6;
            while (param3.digest.bytesAvailable != 0)
            {
                
                _loc_8.writeInt(param3.digest.readInt());
            }
            _loc_8.position = 0;
            while (_loc_8.bytesAvailable != 0)
            {
                
                _loc_5.writeByte(_loc_8.readUnsignedByte());
            }
            return param3.hashBytes(_loc_5);
        }// end function

    }
}
