package com.sulake.habbo.communication.demo
{
   import com.hurlant.math.BigInteger;
   import com.sulake.core.Core;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.communication.ICoreCommunicationManager;
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.encryption.CryptoTools;
   import com.sulake.core.communication.encryption.IEncryption;
   import com.sulake.core.communication.handshake.DiffieHellman;
   import com.sulake.core.communication.handshake.IKeyExchange;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.IContext;
   import com.sulake.core.runtime.IID;
   import com.sulake.core.runtime.IUnknown;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.encryption.PseudoRandom;
   import com.sulake.habbo.communication.encryption.RC4_R27;
   import com.sulake.habbo.communication.enum.HabboCommunicationEvent;
   import com.sulake.habbo.communication.enum.HabboConnectionType;
   import com.sulake.habbo.communication.messages.incoming.error.ErrorReportEvent;
   import com.sulake.habbo.communication.messages.incoming.handshake.AuthenticationOKMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.handshake.DisconnectReasonEvent;
   import com.sulake.habbo.communication.messages.incoming.handshake.GenericErrorEvent;
   import com.sulake.habbo.communication.messages.incoming.handshake.HelloMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.handshake.IdentityAccountsEvent;
   import com.sulake.habbo.communication.messages.incoming.handshake.InitCryptoMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.handshake.PingMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.handshake.SecretKeyEvent;
   import com.sulake.habbo.communication.messages.incoming.handshake.SessionParamsMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.handshake.UniqueMachineIDEvent;
   import com.sulake.habbo.communication.messages.incoming.handshake.UserObjectEvent;
   import com.sulake.habbo.communication.messages.incoming.room.engine.RoomEntryInfoMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.handshake.GenerateSecretKeyMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.handshake.GetSessionParametersMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.handshake.InfoRetrieveMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.handshake.InitCryptoMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.handshake.PongMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.handshake.SSOTicketMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.handshake.TryLoginMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.handshake.UniqueIDMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.handshake.VersionCheckMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.tracking.ConversionPointMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.ScrGetUserInfoMessageComposer;
   import com.sulake.habbo.communication.messages.parser.error.ErrorReportMessageParser;
   import com.sulake.habbo.communication.messages.parser.handshake.GenericErrorParser;
   import com.sulake.habbo.configuration.IHabboConfigurationManager;
   import com.sulake.habbo.session.IRoomSessionManager;
   import com.sulake.habbo.session.events.RoomSessionEvent;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.habbo.window.utils.IAlertDialog;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboConfigurationManager;
   import com.sulake.iid.IIDHabboRoomSessionManager;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.external.ExternalInterface;
   import flash.geom.Point;
   import flash.net.SharedObject;
   import flash.utils.ByteArray;
   import iid.IIDHabboWindowManager;
   
   public class HabboCommunicationDemo extends Component
   {
       
      
      private var var_269:ICoreCommunicationManager;
      
      private var var_141:IHabboConfigurationManager;
      
      private var var_55:IHabboCommunicationManager;
      
      private var _windowManager:IHabboWindowManager;
      
      private var _roomSessionManager:IRoomSessionManager;
      
      private var var_546:IKeyExchange;
      
      private var var_1006:String;
      
      private var _view:HabboLoginDemoView;
      
      private var var_2702:PseudoRandom;
      
      private var var_664:String;
      
      private var var_1960:String;
      
      private var var_1527:Boolean;
      
      private var var_2703:Boolean;
      
      private var var_2704:String;
      
      private var var_232:HabboHotelView;
      
      private var var_1526:String = "";
      
      private const const_1931:String = "fuselogin";
      
      public function HabboCommunicationDemo(param1:IContext, param2:uint = 0, param3:IAssetLibrary = null)
      {
         super(param1,param2,param3);
         queueInterface(new IIDHabboWindowManager(),this.onWindowManagerReady);
         queueInterface(new IIDHabboCommunicationManager(),this.onHabboCommunication);
         queueInterface(new IIDHabboRoomSessionManager(),this.onRoomSessionManagerReady);
         queueInterface(new IIDHabboConfigurationManager(),this.onHabboConfigurationInit);
      }
      
      private static function decode(param1:ByteArray, param2:uint, param3:uint, param4:Point, param5:Point) : String
      {
         var _loc12_:int = 0;
         var _loc13_:* = 0;
         var _loc14_:int = 0;
         var _loc15_:* = 0;
         var _loc16_:* = 0;
         var _loc6_:String = "";
         var _loc7_:int = 0;
         var _loc8_:* = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         if(param3 == 4)
         {
            _loc10_ = 1;
         }
         var _loc11_:int = param4.y;
         while(_loc11_ < param4.y + param5.y)
         {
            _loc12_ = param4.x;
            while(_loc12_ < param4.x + param5.x)
            {
               _loc13_ = uint(((_loc11_ + _loc9_) * param2 + _loc12_) * param3);
               _loc14_ = _loc10_;
               while(_loc14_ < param3)
               {
                  param1.position = _loc13_ + _loc14_;
                  _loc15_ = uint(param1.readUnsignedByte());
                  _loc16_ = uint(_loc15_ & 1);
                  _loc8_ |= _loc16_ << 7 - _loc7_;
                  if(_loc7_ == 7)
                  {
                     _loc6_ += String.fromCharCode(_loc8_);
                     _loc8_ = 0;
                     _loc7_ = 0;
                  }
                  else
                  {
                     _loc7_++;
                  }
                  _loc14_++;
               }
               if(_loc12_ % 2 == 0)
               {
                  _loc9_++;
               }
               _loc12_++;
            }
            _loc9_ = 0;
            _loc11_++;
         }
         return _loc6_;
      }
      
      private static function xor(param1:String, param2:String) : String
      {
         var _loc6_:* = 0;
         var _loc3_:String = "";
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         while(_loc5_ < param1.length)
         {
            _loc6_ = uint(param1.charCodeAt(_loc5_));
            _loc3_ += String.fromCharCode(_loc6_ ^ param2.charCodeAt(_loc4_));
            _loc4_++;
            if(_loc4_ == param2.length)
            {
               _loc4_ = 0;
            }
            _loc5_++;
         }
         return _loc3_;
      }
      
      public function get communicationManager() : ICoreCommunicationManager
      {
         return this.var_269;
      }
      
      public function get habboConfiguration() : IHabboConfigurationManager
      {
         return this.var_141;
      }
      
      public function get habboCommunication() : IHabboCommunicationManager
      {
         return this.var_55;
      }
      
      public function get windowManager() : IHabboWindowManager
      {
         return this._windowManager;
      }
      
      public function set ssoTicket(param1:String) : void
      {
         this.var_664 = param1;
      }
      
      public function set flashClientUrl(param1:String) : void
      {
         this.var_1960 = param1;
      }
      
      override public function dispose() : void
      {
         if(this._view != null)
         {
            this._view.dispose();
            this._view = null;
         }
         if(this.var_232 != null)
         {
            this.var_232.dispose();
            this.var_232 = null;
         }
      }
      
      public function setSSOTicket(param1:String) : void
      {
         if(param1 && !this.var_664)
         {
            this.var_664 = param1;
            this.var_55.initConnection(HabboConnectionType.const_241);
         }
      }
      
      private function onHabboConfigurationInit(param1:IID = null, param2:IUnknown = null) : void
      {
         if(param2 != null)
         {
            this.var_141 = param2 as IHabboConfigurationManager;
            this.checkRequirements();
         }
      }
      
      private function onWindowManagerReady(param1:IID, param2:IUnknown) : void
      {
         this._windowManager = param2 as IHabboWindowManager;
         this.checkRequirements();
      }
      
      private function onRoomSessionManagerReady(param1:IID, param2:IUnknown) : void
      {
         this._roomSessionManager = param2 as IRoomSessionManager;
         this._roomSessionManager.events.addEventListener(RoomSessionEvent.const_98,this.onRoomSessionEnded);
         this.checkRequirements();
      }
      
      private function onHabboCommunication(param1:IID = null, param2:IUnknown = null) : void
      {
         var _loc3_:* = null;
         if(param2 != null)
         {
            this.var_55 = param2 as IHabboCommunicationManager;
            _loc3_ = this.var_55.getHabboMainConnection(null);
            if(_loc3_ != null)
            {
               _loc3_.addEventListener(Event.CONNECT,this.onConnectionEstablished);
               _loc3_.addEventListener(Event.CLOSE,this.onConnectionDisconnected);
            }
            this.var_55.addHabboConnectionMessageEvent(new HelloMessageEvent(this.onHelloEvent));
            this.var_55.addHabboConnectionMessageEvent(new InitCryptoMessageEvent(this.onInitCrypto));
            this.var_55.addHabboConnectionMessageEvent(new SecretKeyEvent(this.onSecretKeyEvent));
            this.var_55.addHabboConnectionMessageEvent(new SessionParamsMessageEvent(this.onSessionParamsEvent));
            this.var_55.addHabboConnectionMessageEvent(new AuthenticationOKMessageEvent(this.onAuthenticationOK));
            this.var_55.addHabboConnectionMessageEvent(new PingMessageEvent(this.onPing));
            this.var_55.addHabboConnectionMessageEvent(new ErrorReportEvent(this.onErrorReport));
            this.var_55.addHabboConnectionMessageEvent(new UserObjectEvent(this.onUserObject));
            this.var_55.addHabboConnectionMessageEvent(new GenericErrorEvent(this.onGenericError));
            this.var_55.addHabboConnectionMessageEvent(new DisconnectReasonEvent(this.onDisconnectReason));
            this.var_55.addHabboConnectionMessageEvent(new RoomEntryInfoMessageEvent(this.onRoomEntryInfoEvent));
            this.var_55.addHabboConnectionMessageEvent(new UniqueMachineIDEvent(this.onUniqueMachineId));
            this.var_55.addHabboConnectionMessageEvent(new IdentityAccountsEvent(this.onIdentityAccounts));
            this.checkRequirements();
         }
      }
      
      private function checkRequirements() : void
      {
         if(this.var_55 && this.var_141 && this._roomSessionManager && this._windowManager)
         {
            this.componentsAreRunning();
         }
      }
      
      private function componentsAreRunning() : void
      {
         var _loc5_:Boolean = false;
         var _loc1_:Boolean = this.var_141.getBoolean("client.hotel_view.show_on_startup",true);
         this.var_232 = new HabboHotelView(this._windowManager,assets,Component(context).events,_loc1_);
         var _loc2_:String = this.var_141.getKey("client.hotel_view.image");
         var _loc3_:String = this.var_141.getKey("image.library.url");
         if(_loc2_ != null && _loc3_ != null)
         {
            this.var_232.loadHotelViewImage(_loc3_ + _loc2_);
         }
         var _loc4_:* = this.var_141.getKey("use.sso.ticket") == "1";
         this.var_664 = this.var_141.getKey("sso.ticket",null);
         this.var_1960 = this.var_141.getKey("flash.client.url","");
         this.var_2704 = this.var_141.getKey("external.variables.txt","");
         if(this.var_232 == null)
         {
            this.var_232 = new HabboHotelView(this._windowManager,assets,Component(context).events,_loc1_);
         }
         if(_loc4_)
         {
            this.var_55.mode = HabboConnectionType.const_99;
            if(this.var_664)
            {
               this.var_55.initConnection(HabboConnectionType.const_241);
            }
            else if(false)
            {
               ExternalInterface.addCallback("setSSOTicket",this.setSSOTicket);
               ExternalInterface.call("requestSSOTicket");
            }
         }
         else if(this._windowManager != null)
         {
            _loc5_ = false;
            if(_loc5_)
            {
               this._view = new HabboLoginDemoView(this);
               this._view.addEventListener(HabboLoginDemoView.const_573,this.onInitConnection);
            }
            else
            {
               Core.crash("Login without an SSO ticket is not supported",Core.const_1673);
            }
         }
      }
      
      private function onInitConnection(param1:Event = null) : void
      {
         this.dispatchLoginStepEvent(HabboCommunicationEvent.INIT);
         if(this.var_664 != null)
         {
            this.var_55.mode = HabboConnectionType.const_99;
         }
         else
         {
            this.var_55.mode = HabboConnectionType.const_99;
            if(this.var_141.keyExists("local.environment"))
            {
               this.var_55.mode = HabboConnectionType.const_1094;
            }
         }
         this.var_55.initConnection(HabboConnectionType.const_241);
      }
      
      private function onConnectionEstablished(param1:Event = null) : void
      {
         var _loc3_:* = null;
         var _loc2_:IConnection = this.var_55.getHabboMainConnection(null);
         if(_loc2_ != null)
         {
            this.dispatchLoginStepEvent(HabboCommunicationEvent.const_800);
            _loc3_ = new InitCryptoMessageComposer(this.var_55.mode);
            _loc2_.send(_loc3_);
         }
      }
      
      private function onHelloEvent(param1:IMessageEvent) : void
      {
      }
      
      private function onInitCrypto(param1:IMessageEvent) : void
      {
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc2_:IConnection = param1.connection;
         var _loc3_:InitCryptoMessageEvent = param1 as InitCryptoMessageEvent;
         var _loc4_:String = _loc3_.token;
         var _loc5_:Boolean = _loc3_.isServerEncrypted;
         this.var_2702 = new PseudoRandom(parseInt(_loc4_.substring(_loc4_.length - 4),16),65536);
         switch(this.var_55.mode)
         {
            case HabboConnectionType.const_99:
               _loc6_ = "";
               _loc6_ = this.var_141.getKey("url.prefix",_loc6_);
               _loc6_ = _loc6_.replace("http://","");
               _loc6_ = _loc6_.replace("https://","");
               _loc7_ = this.var_141.getKey("hotelview.banner.url","http:/\nsitename$/gamedata/banner");
               _loc7_ = _loc7_.replace("$sitename$",_loc6_);
               this.var_1526 = _loc4_;
               this.var_232.loadBannerImage(_loc7_ + "?token=" + this.var_1526,this.onHotelViewBannerLoaded);
               break;
            case HabboConnectionType.const_1094:
               this.sendConnectionParameters(_loc2_);
               break;
            case HabboConnectionType.const_1613:
               this.var_1006 = this.generateRandomHexString(30);
               this.var_546 = new DiffieHellman(new BigInteger(this.var_141.getKey("connection.development.prime"),16),new BigInteger(this.var_141.getKey("connection.development.generator"),16));
               this.var_546.init(this.var_1006);
               _loc8_ = this.var_546.getPublicKey(10);
               _loc2_.send(new GenerateSecretKeyMessageComposer(_loc8_.toUpperCase()));
               break;
            default:
               Logger.log("[HabboCommunicationDemo] Unknown Connection Mode: " + this.var_55.mode);
         }
      }
      
      private function onSecretKeyEvent(param1:IMessageEvent) : void
      {
         var _loc2_:IConnection = param1.connection;
         var _loc3_:SecretKeyEvent = param1 as SecretKeyEvent;
         var _loc4_:String = _loc3_.serverPublicKey;
         this.var_546.generateSharedKey(_loc4_,10);
         var _loc5_:String = this.var_546.getSharedKey(16).toUpperCase();
         var _loc6_:RC4_R27 = new RC4_R27(null,null);
         var _loc7_:IEncryption = new RC4_R27(_loc6_,this.var_2702);
         var _loc8_:ByteArray = CryptoTools.hexStringToByteArray(_loc5_);
         _loc8_.position = 0;
         _loc6_.init(_loc8_);
         _loc8_.position = 0;
         _loc7_.initFromState(_loc6_);
         _loc2_.setEncryption(_loc7_);
         this.sendConnectionParameters(_loc2_);
      }
      
      private function sendConnectionParameters(param1:IConnection) : void
      {
         var so:SharedObject = null;
         var connection:IConnection = param1;
         this.var_1527 = true;
         this.dispatchLoginStepEvent(HabboCommunicationEvent.const_272);
         connection.send(new VersionCheckMessageComposer(401,this.var_1960,this.var_2704));
         var machineId:String = "";
         try
         {
            so = SharedObject.getLocal(this.const_1931,"/");
            if(so.data.machineid != null)
            {
               machineId = so.data.machineid;
            }
         }
         catch(e:Error)
         {
         }
         connection.send(new UniqueIDMessageComposer(machineId));
         connection.send(new GetSessionParametersMessageComposer());
      }
      
      private function onSessionParamsEvent(param1:IMessageEvent) : void
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         this.var_1527 = false;
         var _loc2_:IConnection = param1.connection;
         var _loc3_:SessionParamsMessageEvent = param1 as SessionParamsMessageEvent;
         if(this.var_664 != null)
         {
            _loc4_ = new SSOTicketMessageComposer(this.var_664);
            _loc2_.send(_loc4_);
            this.dispatchLoginStepEvent(HabboCommunicationEvent.const_198);
         }
         else if(this._view != null)
         {
            _loc5_ = this._view.name;
            _loc6_ = this._view.password;
            if(_loc5_.length > 0 && _loc6_.length > 0)
            {
               this.sendTryLogin(_loc5_,_loc6_);
               this.dispatchLoginStepEvent(HabboCommunicationEvent.const_198);
            }
         }
         else
         {
            Logger.log("[HabboCommunicationDemo] Error, no login window nor ticket");
         }
      }
      
      public function sendTryLogin(param1:String, param2:String, param3:int = 0) : void
      {
         var _loc4_:IConnection = this.var_55.getHabboMainConnection(null);
         var _loc5_:TryLoginMessageComposer = new TryLoginMessageComposer(param1,param2,param3);
         _loc4_.send(_loc5_);
      }
      
      private function onAuthenticationOK(param1:IMessageEvent) : void
      {
         var _loc2_:IConnection = param1.connection;
         var _loc3_:AuthenticationOKMessageEvent = param1 as AuthenticationOKMessageEvent;
         Logger.log("Authentication success!");
         var _loc4_:InfoRetrieveMessageComposer = new InfoRetrieveMessageComposer();
         _loc2_.send(_loc4_);
         var _loc5_:ConversionPointMessageComposer = new ConversionPointMessageComposer("Login","socket","client.auth_ok");
         _loc2_.send(_loc5_);
         if(this._view != null)
         {
            this._view.closeLoginWindow();
         }
         this.dispatchLoginStepEvent(HabboCommunicationEvent.const_248);
      }
      
      private function onUserObject(param1:IMessageEvent) : void
      {
         param1.connection.send(new ScrGetUserInfoMessageComposer("habbo_club"));
      }
      
      private function onGenericError(param1:IMessageEvent) : void
      {
         var event:IMessageEvent = param1;
         var parser:GenericErrorParser = (event as GenericErrorEvent).getParser();
         switch(parser.errorCode)
         {
            case -3:
               this._windowManager.alert("${connection.error.id.title}","${connection.login.error.-3.desc}",0,function(param1:IAlertDialog, param2:WindowEvent):void
               {
                  param1.dispose();
               });
               break;
            case -400:
               this._windowManager.alert("${connection.error.id.title}","${connection.login.error.-400.desc}",0,function(param1:IAlertDialog, param2:WindowEvent):void
               {
                  param1.dispose();
               });
         }
      }
      
      private function onPing(param1:IMessageEvent) : void
      {
         var _loc2_:IConnection = param1.connection;
         var _loc3_:PingMessageEvent = param1 as PingMessageEvent;
         var _loc4_:PongMessageComposer = new PongMessageComposer();
         _loc2_.send(_loc4_);
      }
      
      private function onUniqueMachineId(param1:UniqueMachineIDEvent) : void
      {
         var so:SharedObject = null;
         var event:UniqueMachineIDEvent = param1;
         if(event == null)
         {
            return;
         }
         try
         {
            so = SharedObject.getLocal(this.const_1931,"/");
            so.data.machineid = event.machineID;
            so.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      private function onIdentityAccounts(param1:IdentityAccountsEvent) : void
      {
         if(!param1)
         {
            return;
         }
         if(this._view)
         {
            this._view.populateUserList(param1.getParser().accounts);
         }
      }
      
      private function onErrorReport(param1:IMessageEvent) : void
      {
         var event:IMessageEvent = param1;
         var parser:ErrorReportMessageParser = (event as ErrorReportEvent).getParser();
         var errorCode:int = parser.errorCode;
         var messageId:int = parser.messageId;
         var time:String = parser.timestamp;
         Logger.log("SERVER ERROR! Error code:" + errorCode + "Message id:" + messageId);
         this._windowManager.registerLocalizationParameter("connection.server.error.desc","errorCode",String(errorCode));
         this._windowManager.alert("${connection.server.error.title}","${connection.server.error.desc}",0,function(param1:IAlertDialog, param2:WindowEvent):void
         {
            param1.dispose();
         });
      }
      
      private function onConnectionDisconnected(param1:Event) : void
      {
         var _loc2_:* = null;
         if(this.var_1527)
         {
            this.dispatchLoginStepEvent(HabboCommunicationEvent.const_225);
         }
         if(param1.type == Event.CLOSE && !this.var_2703)
         {
            _loc2_ = this.var_141.getKey("logout.disconnect.url");
            _loc2_ = this.setOriginProperty(_loc2_);
            HabboWebTools.openWebPage(_loc2_,"_self");
         }
      }
      
      private function onDisconnectReason(param1:DisconnectReasonEvent) : void
      {
         if(this.var_1527)
         {
            this.dispatchLoginStepEvent(HabboCommunicationEvent.const_225);
         }
         this.var_2703 = true;
         var _loc2_:String = this.var_141.getKey("logout.url");
         if(_loc2_.length > 0)
         {
            _loc2_ = this.setReasonProperty(_loc2_,param1.reasonString);
            _loc2_ = this.setOriginProperty(_loc2_);
            _loc2_ += "&id=" + param1.reason;
            HabboWebTools.openWebPage(_loc2_,"_self");
         }
      }
      
      private function setReasonProperty(param1:String, param2:String) : String
      {
         if(param1.indexOf("%reason%") != -1)
         {
            return param1.replace("%reason%",param2);
         }
         return param1;
      }
      
      private function setOriginProperty(param1:String) : String
      {
         if(param1.indexOf("%origin%") != -1)
         {
            return param1.replace("%origin%",this.var_141.getKey("flash.client.origin","popup"));
         }
         return param1;
      }
      
      private function onRoomEntryInfoEvent(param1:RoomEntryInfoMessageEvent) : void
      {
         if(this.var_232)
         {
            if(!this.var_232.disposed)
            {
               this.var_232.hide();
            }
         }
      }
      
      private function onRoomSessionEnded(param1:RoomSessionEvent) : void
      {
         if(!this._roomSessionManager.sessionStarting)
         {
            this.showHotelView();
         }
      }
      
      private function showHotelView() : void
      {
         if(this.var_232)
         {
            if(!this.var_232.disposed)
            {
               this.var_232.show();
            }
         }
      }
      
      private function dispatchLoginStepEvent(param1:String) : void
      {
         if(Component(context) == null || Component(context).events == null)
         {
            return;
         }
         Component(context).events.dispatchEvent(new Event(param1));
      }
      
      private function onHotelViewBannerLoaded(param1:BitmapData) : void
      {
         var _loc15_:* = null;
         var _loc2_:ByteArray = param1.getPixels(param1.rect);
         var _loc3_:String = decode(_loc2_,param1.width,4,new Point(4,39),new Point(80,30));
         var _loc4_:String = xor(_loc3_,this.var_1526);
         var _loc5_:uint = _loc4_.charCodeAt(0);
         var _loc6_:uint = _loc4_.charCodeAt(_loc5_ + 1);
         var _loc7_:String = _loc4_.substr(1,_loc5_);
         var _loc8_:String = _loc4_.substr(_loc5_ + 2,_loc6_);
         var _loc9_:IConnection = this.var_55.getHabboMainConnection(null);
         var _loc10_:BigInteger = new BigInteger();
         var _loc11_:BigInteger = new BigInteger();
         var _loc12_:* = null;
         _loc10_.fromRadix(_loc7_,10);
         _loc11_.fromRadix(_loc8_,10);
         this.var_546 = new DiffieHellman(_loc10_,_loc11_);
         var _loc13_:int = 10;
         var _loc14_:* = null;
         while(_loc13_ > 0)
         {
            _loc14_ = this.generateRandomHexString(30);
            this.var_546.init(_loc14_);
            _loc15_ = this.var_546.getPublicKey(10);
            if(_loc15_.length >= 64)
            {
               _loc12_ = _loc15_;
               this.var_1006 = _loc14_;
            }
            if(_loc12_ == null || _loc15_.length > _loc12_.length)
            {
               _loc12_ = _loc15_;
               this.var_1006 = _loc14_;
            }
            _loc13_--;
         }
         if(_loc14_ != this.var_1006)
         {
            this.var_546.init(this.var_1006);
         }
         _loc9_.send(new GenerateSecretKeyMessageComposer(_loc12_.toUpperCase()));
         this.var_1526 = "";
      }
      
      private function generateRandomHexString(param1:uint = 16) : String
      {
         var _loc4_:* = 0;
         var _loc2_:String = "";
         var _loc3_:int = 0;
         while(_loc3_ < param1)
         {
            _loc4_ = uint(uint(Math.random() * 255));
            _loc2_ += _loc4_.toString(16);
            _loc3_++;
         }
         return _loc2_;
      }
   }
}
