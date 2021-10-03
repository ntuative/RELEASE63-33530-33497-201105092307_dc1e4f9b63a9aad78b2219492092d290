package com.sulake.core.runtime
{
   import com.sulake.core.assets.AssetLibrary;
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.utils.profiler.ProfilerAgent;
   import com.sulake.core.utils.profiler.tracking.TrackedBitmapData;
   import flash.events.Event;
   import flash.net.LocalConnection;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   class Profiler extends Component implements IProfiler
   {
      
      public static const PROFILER_START:String = "PROFILER_START";
      
      public static const PROFILER_STOP:String = "PROFILER_STOP";
       
      
      private var var_315:Dictionary;
      
      private var var_2016:int;
      
      private var var_2944:int;
      
      function Profiler(param1:IContext)
      {
         this.var_315 = new Dictionary(true);
         super(param1,0,null);
      }
      
      public function get numAssetLibraryInstances() : uint
      {
         return AssetLibrary.numAssetLibraryInstances;
      }
      
      public function get numBitmapAssetInstances() : uint
      {
         return BitmapDataAsset.instances;
      }
      
      public function get numAllocatedBitmapDataBytes() : uint
      {
         return BitmapDataAsset.allocatedByteCount;
      }
      
      public function get numTrackedBitmapDataInstances() : uint
      {
         return TrackedBitmapData.numInstances;
      }
      
      public function get numTrackedBitmapDataBytes() : uint
      {
         return TrackedBitmapData.allocatedByteCount;
      }
      
      override public function dispose() : void
      {
         var _loc1_:* = null;
         if(!disposed)
         {
            for(_loc1_ in this.var_315)
            {
               IDisposable(this.var_315[_loc1_]).dispose();
               delete this.var_315[_loc1_];
            }
            super.dispose();
         }
      }
      
      public function gc() : void
      {
         try
         {
            new LocalConnection().connect("foo");
            new LocalConnection().connect("foo");
         }
         catch(e:*)
         {
         }
      }
      
      public function start() : void
      {
         events.dispatchEvent(new Event(PROFILER_START,false,false));
         this.var_2016 = getTimer();
      }
      
      public function stop() : void
      {
         this.var_2944 = getTimer() - this.var_2016;
         events.dispatchEvent(new Event(PROFILER_STOP,false,false));
      }
      
      public function update(param1:IUpdateReceiver, param2:uint) : void
      {
         this.getProfilerAgentForReceiver(param1).update(param2);
      }
      
      public function get numProfilerAgents() : uint
      {
         var _loc2_:* = null;
         var _loc1_:int = 0;
         for(_loc2_ in this.var_315)
         {
            if(!IDisposable(_loc2_).disposed)
            {
               _loc1_++;
            }
         }
         return _loc1_;
      }
      
      public function getProfilerAgentsInArray() : Array
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc1_:Array = new Array();
         for(_loc3_ in this.var_315)
         {
            _loc2_ = _loc3_ as IUpdateReceiver;
            if(IDisposable(_loc3_).disposed)
            {
               IDisposable(this.var_315[_loc3_]).dispose();
               delete this.var_315[_loc3_];
            }
            else
            {
               _loc1_.push(this.var_315[_loc3_]);
            }
         }
         return _loc1_;
      }
      
      public function getProfilerAgentForReceiver(param1:IUpdateReceiver) : ProfilerAgent
      {
         var _loc2_:ProfilerAgent = this.var_315[param1];
         return _loc2_ != null ? _loc2_ : this.addProfilerAgentForReceiver(param1);
      }
      
      public function addProfilerAgentForReceiver(param1:IUpdateReceiver) : ProfilerAgent
      {
         if(this.var_315[param1] != null)
         {
            throw new Error("Profiler for receiver already exists!");
         }
         var _loc2_:ProfilerAgent = new ProfilerAgent(param1);
         this.var_315[param1] = _loc2_;
         return _loc2_;
      }
      
      public function addStartEventListener(param1:Function) : void
      {
         events.addEventListener(PROFILER_START,param1);
      }
      
      public function addStopEventListener(param1:Function) : void
      {
         events.addEventListener(PROFILER_STOP,param1);
      }
      
      public function removeStartEventListener(param1:Function) : void
      {
         events.removeEventListener(PROFILER_START,param1);
      }
      
      public function removeStopEventListener(param1:Function) : void
      {
         events.removeEventListener(PROFILER_STOP,param1);
      }
   }
}
