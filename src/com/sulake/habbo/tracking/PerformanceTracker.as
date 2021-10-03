package com.sulake.habbo.tracking
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.utils.debug.GarbageMonitor;
   import com.sulake.habbo.communication.messages.outgoing.tracking.PerformanceLogMessageComposer;
   import com.sulake.habbo.configuration.IHabboConfigurationManager;
   import flash.external.ExternalInterface;
   import flash.system.Capabilities;
   import flash.system.System;
   import flash.utils.getTimer;
   
   public class PerformanceTracker
   {
       
      
      private var _connection:IConnection = null;
      
      private var var_182:IHabboConfigurationManager = null;
      
      private var var_573:int = 0;
      
      private var var_536:Number = 0;
      
      private var var_2939:Array;
      
      private var var_1486:String = "";
      
      private var var_1881:String = "";
      
      private var var_2256:String = "";
      
      private var var_2255:String = "";
      
      private var var_1679:Boolean = false;
      
      private var var_1879:GarbageMonitor = null;
      
      private var var_1488:int = 0;
      
      private var var_2608:Boolean;
      
      private var var_1878:int = 1000;
      
      private var var_1487:int = 0;
      
      private var _reportInterval:int = 60;
      
      private var var_1853:int = 0;
      
      private var var_1880:int = 10;
      
      private var var_1489:int = 0;
      
      private var var_2605:Number = 0.15;
      
      private var var_2607:Boolean = true;
      
      private var var_2606:Number = 0;
      
      public function PerformanceTracker()
      {
         this.var_2939 = [];
         super();
         this.var_1881 = Capabilities.version;
         this.var_2256 = Capabilities.os;
         this.var_1679 = Capabilities.isDebugger;
         this.var_1486 = !true ? ExternalInterface.call("window.navigator.userAgent.toString") : "unknown";
         if(this.var_1486 == null)
         {
            this.var_1486 = "unknown";
         }
         this.var_1879 = new GarbageMonitor();
         this.updateGarbageMonitor();
         this.var_1853 = getTimer();
      }
      
      public function get flashVersion() : String
      {
         return this.var_1881;
      }
      
      public function get averageUpdateInterval() : int
      {
         return this.var_536;
      }
      
      public function set slowUpdateLimit(param1:int) : void
      {
         this.var_1878 = param1;
      }
      
      public function set reportInterval(param1:int) : void
      {
         this._reportInterval = param1;
      }
      
      public function set reportLimit(param1:int) : void
      {
         this.var_1880 = param1;
      }
      
      public function set connection(param1:IConnection) : void
      {
         this._connection = param1;
      }
      
      public function set configuration(param1:IHabboConfigurationManager) : void
      {
         this.var_182 = param1;
         this._reportInterval = int(this.var_182.getKey("performancetest.interval","60"));
         this.var_1878 = int(this.var_182.getKey("performancetest.slowupdatelimit","1000"));
         this.var_1880 = int(this.var_182.getKey("performancetest.reportlimit","10"));
         this.var_2605 = Number(this.var_182.getKey("performancetest.distribution.deviancelimit.percent","10"));
         this.var_2607 = Boolean(int(this.var_182.getKey("performancetest.distribution.enabled","1")));
         this.var_2608 = Boolean(this.var_182.getKey("monitor.garbage.collection","0") == "1");
      }
      
      public function dispose() : void
      {
      }
      
      private function updateGarbageMonitor() : Object
      {
         var _loc2_:* = null;
         var _loc1_:Array = this.var_1879.list;
         if(_loc1_ == null || _loc1_.length == 0)
         {
            _loc2_ = new GarbageTester("tester");
            this.var_1879.insert(_loc2_,"tester");
            return _loc2_;
         }
         return null;
      }
      
      public function update(param1:uint, param2:int) : void
      {
         var _loc4_:* = null;
         var _loc5_:Number = NaN;
         var _loc6_:int = 0;
         var _loc7_:Boolean = false;
         var _loc8_:Number = NaN;
         if(this.var_2608)
         {
            _loc4_ = this.updateGarbageMonitor();
            if(_loc4_ != null)
            {
               ++this.var_1488;
               Logger.log("Garbage collection");
            }
         }
         var _loc3_:Boolean = false;
         if(param1 > this.var_1878)
         {
            ++this.var_1487;
            _loc3_ = true;
         }
         else
         {
            ++this.var_573;
            if(this.var_573 <= 1)
            {
               this.var_536 = param1;
            }
            else
            {
               _loc5_ = Number(this.var_573);
               this.var_536 = this.var_536 * (_loc5_ - 1) / _loc5_ + Number(param1) / _loc5_;
            }
         }
         if(param2 - this.var_1853 > this._reportInterval * 1000 && this.var_1489 < this.var_1880)
         {
            _loc6_ = 0;
            Logger.log("*** Performance tracker: average frame rate " + 1000 / this.var_536 + "/s, system memory usage : " + _loc6_ + " bytes");
            _loc7_ = true;
            if(this.var_2607 && this.var_1489 > 0)
            {
               _loc8_ = this.differenceInPercents(this.var_2606,this.var_536);
               if(_loc8_ < this.var_2605)
               {
                  _loc7_ = false;
               }
            }
            this.var_1853 = param2;
            if(_loc7_ || _loc3_)
            {
               this.var_2606 = this.var_536;
               if(this.sendReport(param2))
               {
                  ++this.var_1489;
               }
            }
         }
      }
      
      private function sendReport(param1:int) : Boolean
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(this._connection != null)
         {
            _loc2_ = null;
            _loc3_ = param1 / 1000;
            _loc4_ = -1;
            _loc5_ = 0;
            _loc2_ = new PerformanceLogMessageComposer(_loc3_,this.var_1486,this.var_1881,this.var_2256,this.var_2255,this.var_1679,_loc5_,_loc4_,this.var_1488,this.var_536,this.var_1487);
            this._connection.send(_loc2_);
            this.var_1488 = 0;
            this.var_536 = 0;
            this.var_573 = 0;
            this.var_1487 = 0;
            return true;
         }
         return false;
      }
      
      private function differenceInPercents(param1:Number, param2:Number) : Number
      {
         if(param1 == param2)
         {
            return 0;
         }
         var _loc3_:Number = param1;
         var _loc4_:Number = param2;
         if(param2 > param1)
         {
            _loc3_ = param2;
            _loc4_ = param1;
         }
         return 100 * (1 - _loc4_ / _loc3_);
      }
   }
}
