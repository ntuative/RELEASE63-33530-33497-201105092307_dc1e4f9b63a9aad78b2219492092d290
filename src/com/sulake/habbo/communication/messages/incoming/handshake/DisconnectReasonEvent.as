package com.sulake.habbo.communication.messages.incoming.handshake
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.handshake.DisconnectReasonParser;
   
   public class DisconnectReasonEvent extends MessageEvent implements IMessageEvent
   {
      
      public static const const_2125:int = 0;
      
      public static const const_1874:int = 1;
      
      public static const const_1707:int = 2;
      
      public static const const_2092:int = 3;
      
      public static const const_1951:int = 4;
      
      public static const const_2056:int = 5;
      
      public static const const_1708:int = 10;
      
      public static const const_1994:int = 11;
      
      public static const const_1941:int = 12;
      
      public static const const_2053:int = 13;
      
      public static const const_2015:int = 16;
      
      public static const const_1990:int = 17;
      
      public static const const_1981:int = 18;
      
      public static const const_2113:int = 19;
      
      public static const const_2099:int = 20;
      
      public static const const_2068:int = 22;
      
      public static const const_2074:int = 23;
      
      public static const const_1992:int = 24;
      
      public static const const_1959:int = 25;
      
      public static const const_2059:int = 26;
      
      public static const const_1945:int = 27;
      
      public static const const_2025:int = 28;
      
      public static const const_2061:int = 29;
      
      public static const const_2127:int = 100;
      
      public static const const_2094:int = 101;
      
      public static const const_1998:int = 102;
      
      public static const const_2044:int = 103;
      
      public static const const_2103:int = 104;
      
      public static const const_2002:int = 105;
      
      public static const const_1993:int = 106;
      
      public static const const_2089:int = 107;
      
      public static const const_1972:int = 108;
      
      public static const const_1991:int = 109;
      
      public static const const_1958:int = 110;
      
      public static const const_2016:int = 111;
      
      public static const const_2149:int = 112;
      
      public static const const_2009:int = 113;
      
      public static const const_2100:int = 114;
      
      public static const const_1989:int = 115;
      
      public static const const_1996:int = 116;
      
      public static const const_2128:int = 117;
      
      public static const const_2065:int = 118;
      
      public static const const_1966:int = 119;
       
      
      public function DisconnectReasonEvent(param1:Function)
      {
         super(param1,DisconnectReasonParser);
      }
      
      public function get reason() : int
      {
         return (this.var_10 as DisconnectReasonParser).reason;
      }
      
      public function get reasonString() : String
      {
         switch(this.reason)
         {
            case const_1874:
            case const_1708:
               return "banned";
            case const_1707:
               return "concurrentlogin";
            default:
               return "logout";
         }
      }
   }
}
