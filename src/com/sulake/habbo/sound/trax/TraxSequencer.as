package com.sulake.habbo.sound.trax
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.sound.IHabboSound;
   import com.sulake.habbo.sound.events.SoundCompleteEvent;
   import flash.events.IEventDispatcher;
   import flash.events.SampleDataEvent;
   import flash.events.TimerEvent;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class TraxSequencer implements IHabboSound, IDisposable
   {
      
      private static const const_120:Number = 44100;
      
      private static const const_189:uint = 8192;
      
      private static const const_1414:uint = 88000;
      
      private static const const_1415:uint = 88000;
      
      private static const const_300:Vector.<int> = new Vector.<int>(const_189,true);
       
      
      private var _disposed:Boolean = false;
      
      private var _events:IEventDispatcher;
      
      private var var_496:Number;
      
      private var var_930:Sound;
      
      private var var_426:SoundChannel;
      
      private var var_1157:TraxData;
      
      private var var_1763:Map;
      
      private var var_1074:Boolean;
      
      private var var_1650:int;
      
      private var var_1421:int = 0;
      
      private var var_201:uint;
      
      private var var_428:Array;
      
      private var var_1762:Boolean;
      
      private var var_618:Boolean = true;
      
      private var var_354:uint;
      
      private var var_1422:uint;
      
      private var var_931:Boolean;
      
      private var var_752:Boolean;
      
      private var var_751:int;
      
      private var var_425:int;
      
      private var var_929:int;
      
      private var var_510:int;
      
      private var var_617:Timer;
      
      private var var_427:Timer;
      
      private var var_1156:int = 0;
      
      private var var_1764:int = 0;
      
      public function TraxSequencer(param1:int, param2:TraxData, param3:Map, param4:IEventDispatcher)
      {
         this.var_1422 = uint(30);
         super();
         this._events = param4;
         this.var_1650 = param1;
         this.var_496 = 1;
         this.var_930 = new Sound();
         this.var_426 = null;
         this.var_1763 = param3;
         this.var_1157 = param2;
         this.var_1074 = true;
         this.var_201 = 0;
         this.var_428 = [];
         this.var_1762 = false;
         this.var_354 = 0;
         this.var_618 = false;
         this.var_931 = false;
         this.var_752 = false;
         this.var_751 = 0;
         this.var_425 = 0;
         this.var_929 = 0;
         this.var_510 = 0;
      }
      
      public function set position(param1:Number) : void
      {
         this.var_201 = uint(param1 * const_120);
      }
      
      public function get volume() : Number
      {
         return this.var_496;
      }
      
      public function get position() : Number
      {
         return this.var_201 / const_120;
      }
      
      public function get ready() : Boolean
      {
         return this.var_1074;
      }
      
      public function set ready(param1:Boolean) : void
      {
         this.var_1074 = param1;
      }
      
      public function get finished() : Boolean
      {
         return this.var_618;
      }
      
      public function get fadeOutSeconds() : Number
      {
         return this.var_425 / const_120;
      }
      
      public function set fadeOutSeconds(param1:Number) : void
      {
         this.var_425 = int(param1 * const_120);
      }
      
      public function get fadeInSeconds() : Number
      {
         return this.var_751 / const_120;
      }
      
      public function set fadeInSeconds(param1:Number) : void
      {
         this.var_751 = int(param1 * const_120);
      }
      
      public function get traxData() : TraxData
      {
         return this.var_1157;
      }
      
      public function set volume(param1:Number) : void
      {
         this.var_496 = param1;
         if(this.var_426 != null)
         {
            this.var_426.soundTransform = new SoundTransform(this.var_496);
         }
      }
      
      public function get length() : Number
      {
         return this.var_354 / const_120;
      }
      
      public function get disposed() : Boolean
      {
         return this._disposed;
      }
      
      public function dispose() : void
      {
         if(!this._disposed)
         {
            this.stopImmediately();
            this.var_1157 = null;
            this.var_1763 = null;
            this.var_428 = null;
            this._events = null;
            this.var_930 = null;
            this._disposed = true;
         }
      }
      
      public function prepare() : Boolean
      {
         if(!this.var_1074)
         {
            Logger.log("Cannot start trax playback until samples ready!");
            return false;
         }
         if(!this.var_1762)
         {
            if(!this.prepareSequence())
            {
               Logger.log("Cannot start playback, prepare sequence failed!");
               return false;
            }
         }
         return true;
      }
      
      private function prepareSequence() : Boolean
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:* = null;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         if(this.var_428 == null)
         {
            return false;
         }
         var _loc1_:uint = getTimer();
         var _loc2_:int = 0;
         while(_loc2_ < this.var_1157.channels.length)
         {
            _loc3_ = new Map();
            _loc4_ = this.var_1157.channels[_loc2_] as TraxChannel;
            _loc5_ = 0;
            _loc6_ = 0;
            _loc7_ = 0;
            while(_loc7_ < _loc4_.itemCount)
            {
               _loc8_ = _loc4_.getItem(_loc7_).id;
               _loc9_ = this.var_1763.getValue(_loc8_) as TraxSample;
               _loc9_.setUsageFromSong(this.var_1650,_loc1_);
               if(_loc9_ == null)
               {
                  Logger.log("Error in prepareSequence(), sample was null!");
               }
               continue;
               _loc10_ = this.getSampleBars(_loc9_.length);
               _loc11_ = _loc4_.getItem(_loc7_).length / _loc10_;
               _loc12_ = 0;
               while(_loc12_ < _loc11_)
               {
                  if(_loc8_ != 0)
                  {
                     _loc3_.add(_loc5_,_loc9_);
                  }
                  _loc6_ += _loc10_;
                  _loc5_ = uint(_loc6_ * const_1415);
                  _loc12_++;
               }
               if(this.var_354 < _loc5_)
               {
                  this.var_354 = _loc5_;
               }
               _loc7_++;
               return false;
            }
            this.var_428.push(_loc3_);
            _loc2_++;
         }
         this.var_1762 = true;
         return true;
      }
      
      public function play(param1:Number = 0.0) : Boolean
      {
         if(!this.prepare())
         {
            return false;
         }
         this.removeFadeoutStopTimer();
         if(this.var_426 != null)
         {
            this.stopImmediately();
         }
         if(this.var_751 > 0)
         {
            this.var_931 = true;
            this.var_929 = 0;
         }
         this.var_752 = false;
         this.var_510 = 0;
         this.var_618 = false;
         this.var_930.addEventListener(SampleDataEvent.SAMPLE_DATA,this.onSampleData);
         this.var_1421 = param1 * const_120;
         this.var_1156 = 0;
         this.var_1764 = 0;
         this.var_426 = this.var_930.play();
         this.volume = this.var_496;
         return true;
      }
      
      public function render(param1:SampleDataEvent) : Boolean
      {
         if(!this.prepare())
         {
            return false;
         }
         while(!this.var_618)
         {
            this.onSampleData(param1);
         }
         return true;
      }
      
      public function stop() : Boolean
      {
         if(this.var_425 > 0 && !this.var_618)
         {
            this.stopWithFadeout();
         }
         else
         {
            this.playingComplete();
         }
         return true;
      }
      
      private function stopImmediately() : void
      {
         this.removeStopTimer();
         if(this.var_426 != null)
         {
            this.var_426.stop();
            this.var_426 = null;
         }
         if(this.var_930 != null)
         {
            this.var_930.removeEventListener(SampleDataEvent.SAMPLE_DATA,this.onSampleData);
         }
      }
      
      private function stopWithFadeout() : void
      {
         if(this.var_617 == null)
         {
            this.var_752 = true;
            this.var_510 = 0;
            this.var_617 = new Timer(this.var_1422 + this.var_425 / (const_120 / 1000),1);
            this.var_617.start();
            this.var_617.addEventListener(TimerEvent.TIMER_COMPLETE,this.onFadeOutComplete);
         }
      }
      
      private function getSampleBars(param1:uint) : int
      {
         return Math.ceil(param1 / const_1414);
      }
      
      private function getChannelSequenceOffsets() : Array
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc1_:* = [];
         if(this.var_428 != null)
         {
            _loc2_ = this.var_428.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc4_ = this.var_428[_loc3_];
               _loc5_ = 0;
               while(_loc5_ < _loc4_.length && _loc4_.getKey(_loc5_) < this.var_201)
               {
                  _loc5_++;
               }
               _loc1_.push(_loc5_ - 1);
               _loc3_++;
            }
         }
         return _loc1_;
      }
      
      private function mixChannelsIntoBuffer() : void
      {
         var _loc5_:* = null;
         var _loc6_:int = 0;
         var _loc7_:* = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         if(this.var_428 == null)
         {
            return;
         }
         var _loc1_:Array = this.getChannelSequenceOffsets();
         var _loc2_:int = this.var_428.length;
         var _loc3_:* = null;
         var _loc4_:int = _loc2_ - 1;
         while(_loc4_ >= 0)
         {
            _loc5_ = this.var_428[_loc4_];
            _loc6_ = _loc1_[_loc4_];
            _loc7_ = _loc5_.getWithIndex(_loc6_);
            if(_loc7_ == null)
            {
               _loc3_ = null;
            }
            else
            {
               _loc10_ = _loc5_.getKey(_loc6_);
               _loc11_ = this.var_201 - _loc10_;
               if(_loc7_.id == 0 || _loc11_ < 0)
               {
                  _loc3_ = null;
               }
               else
               {
                  _loc3_ = new TraxChannelSample(_loc7_,_loc11_);
               }
            }
            _loc8_ = const_189;
            if(this.var_354 - this.var_201 < _loc8_)
            {
               _loc8_ = this.var_354 - this.var_201;
            }
            _loc9_ = 0;
            while(_loc9_ < _loc8_)
            {
               _loc12_ = _loc8_;
               if(_loc6_ < _loc5_.length - 1)
               {
                  _loc13_ = _loc5_.getKey(_loc6_ + 1);
                  if(_loc8_ + this.var_201 >= _loc13_)
                  {
                     _loc12_ = _loc13_ - this.var_201;
                  }
               }
               if(_loc12_ > _loc8_ - _loc9_)
               {
                  _loc12_ = _loc8_ - _loc9_;
               }
               if(_loc4_ == _loc2_ - 1)
               {
                  if(_loc3_ != null)
                  {
                     _loc3_.setSample(const_300,_loc9_,_loc12_);
                     _loc9_ += _loc12_;
                  }
                  else
                  {
                     _loc14_ = 0;
                     while(_loc14_ < _loc12_)
                     {
                        var _loc15_:*;
                        const_300[_loc15_ = _loc9_++] = 0;
                        _loc14_++;
                     }
                  }
               }
               else
               {
                  if(_loc3_ != null)
                  {
                     _loc3_.addSample(const_300,_loc9_,_loc12_);
                  }
                  _loc9_ += _loc12_;
               }
               if(_loc9_ < _loc8_)
               {
                  _loc7_ = _loc5_.getWithIndex(++_loc6_);
                  if(_loc7_ == null || _loc7_.id == 0)
                  {
                     _loc3_ = null;
                  }
                  else
                  {
                     _loc3_ = new TraxChannelSample(_loc7_,0);
                  }
               }
            }
            _loc4_--;
         }
      }
      
      private function checkSongFinishing() : void
      {
         var _loc1_:int = this.var_354 < this.var_1421 ? int(this.var_354) : (this.var_1421 > 0 ? int(this.var_1421) : int(this.var_354));
         if(this.var_201 > _loc1_ + this.var_1422 * (const_120 / 1000) && !this.var_618)
         {
            this.var_618 = true;
            if(this.var_427 != null)
            {
               this.var_427.reset();
               this.var_427.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onPlayingComplete);
            }
            this.var_427 = new Timer(2,1);
            this.var_427.start();
            this.var_427.addEventListener(TimerEvent.TIMER_COMPLETE,this.onPlayingComplete);
         }
         else if(this.var_201 > _loc1_ - this.var_425 && !this.var_752)
         {
            this.var_931 = false;
            this.var_752 = true;
            this.var_510 = 0;
         }
      }
      
      private function onSampleData(param1:SampleDataEvent) : void
      {
         if(param1.position > this.var_1156)
         {
            ++this.var_1764;
            Logger.log("Audio buffer under run...");
            this.var_1156 = param1.position;
         }
         if(this.volume > 0)
         {
            this.mixChannelsIntoBuffer();
         }
         var _loc2_:int = const_189;
         if(this.var_354 - this.var_201 < _loc2_)
         {
            _loc2_ = this.var_354 - this.var_201;
            if(_loc2_ < 0)
            {
               _loc2_ = 0;
            }
         }
         if(this.volume <= 0)
         {
            _loc2_ = 0;
         }
         this.writeAudioToOutputStream(param1.data,_loc2_);
         this.var_201 += const_189;
         this.var_1156 += const_189;
         if(this.var_426 != null)
         {
            this.var_1422 = param1.position / const_120 * 1000 - this.var_426.position;
         }
         this.checkSongFinishing();
      }
      
      private function writeAudioToOutputStream(param1:ByteArray, param2:int) : void
      {
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         if(param2 > 0)
         {
            if(!this.var_931 && !this.var_752)
            {
               this.writeMixingBufferToOutputStream(param1,param2);
            }
            else
            {
               if(this.var_931)
               {
                  _loc5_ = 1 / this.var_751;
                  _loc6_ = this.var_929 / Number(this.var_751);
                  this.var_929 += const_189;
                  if(this.var_929 > this.var_751)
                  {
                     this.var_931 = false;
                  }
               }
               else if(this.var_752)
               {
                  _loc5_ = -1 / this.var_425;
                  _loc6_ = 1 - this.var_510 / Number(this.var_425);
                  this.var_510 += const_189;
                  if(this.var_510 > this.var_425)
                  {
                     this.var_510 = this.var_425;
                  }
               }
               this.writeMixingBufferToOutputStreamWithFade(param1,param2,_loc6_,_loc5_);
            }
         }
         var _loc4_:int = param2;
         while(_loc4_ < const_189)
         {
            param1.writeFloat(0);
            param1.writeFloat(0);
            _loc4_++;
         }
      }
      
      private function writeMixingBufferToOutputStream(param1:ByteArray, param2:int) : void
      {
         var _loc3_:* = 0;
         var _loc4_:int = 0;
         while(_loc4_ < param2)
         {
            _loc3_ = Number(Number(const_300[_loc4_]) * 0);
            param1.writeFloat(_loc3_);
            param1.writeFloat(_loc3_);
            _loc4_++;
         }
      }
      
      private function writeMixingBufferToOutputStreamWithFade(param1:ByteArray, param2:int, param3:Number, param4:Number) : void
      {
         var _loc5_:* = 0;
         var _loc6_:int = 0;
         _loc6_ = 0;
         while(_loc6_ < param2)
         {
            if(param3 < 0 || param3 > 1)
            {
               break;
            }
            _loc5_ = Number(Number(const_300[_loc6_]) * 0 * param3);
            param3 += param4;
            param1.writeFloat(_loc5_);
            param1.writeFloat(_loc5_);
            _loc6_++;
         }
         if(param3 < 0)
         {
            while(_loc6_ < param2)
            {
               param1.writeFloat(0);
               param1.writeFloat(0);
               _loc6_++;
            }
         }
         else if(param3 > 1)
         {
            while(_loc6_ < param2)
            {
               _loc5_ = Number(Number(const_300[_loc6_]) * 0);
               param3 += param4;
               param1.writeFloat(_loc5_);
               param1.writeFloat(_loc5_);
               _loc6_++;
            }
         }
      }
      
      private function onPlayingComplete(param1:TimerEvent) : void
      {
         if(this.var_618)
         {
            this.playingComplete();
         }
      }
      
      private function onFadeOutComplete(param1:TimerEvent) : void
      {
         this.removeFadeoutStopTimer();
         this.playingComplete();
      }
      
      private function playingComplete() : void
      {
         this.stopImmediately();
         this._events.dispatchEvent(new SoundCompleteEvent(SoundCompleteEvent.TRAX_SONG_COMPLETE,this.var_1650));
      }
      
      private function removeFadeoutStopTimer() : void
      {
         if(this.var_617 != null)
         {
            this.var_617.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onFadeOutComplete);
            this.var_617.reset();
            this.var_617 = null;
         }
      }
      
      private function removeStopTimer() : void
      {
         if(this.var_427 != null)
         {
            this.var_427.reset();
            this.var_427.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onPlayingComplete);
            this.var_427 = null;
         }
      }
   }
}
