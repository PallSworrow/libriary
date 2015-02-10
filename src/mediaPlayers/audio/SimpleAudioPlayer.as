package mediaPlayers.audio 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import scrollers.interfaces.IscrollController;
	import scrollers.interfaces.Iscroller;
	import scrollers.propsObjects.ScrollProperties;
	import simpleButton.BtnPhaze;
	import simpleButton.Button;
	import simpleButton.events.BtnEvent;
	import simpleButton.interfaces.Ibtn;
	
	/**
	 * ...
	 * @author 
	 */
	public class SimpleAudioPlayer extends Sprite implements IscrollController
	{
		private var _playPauseBtn:Ibtn;
		private var _progressBar:Iscroller;
		private var volumeBar:Iscroller;
		private var title:TextField;
		private var trackName:TextField;
		
		private var _isPlaying:Boolean = false;
		private var sndChannel:SoundChannel = new SoundChannel();
		private var snd:Sound = new Sound();
		private var sndTransform:SoundTransform = sndChannel.soundTransform;
		public function SimpleAudioPlayer() 
		{
			super();
			
		}
		//views:
		public function get playPauseBtn():Ibtn 
		{
			return _playPauseBtn;
		}
		
		public function set playPauseBtn(value:Ibtn):void 
		{
			(_playPauseBtn)
			{
				_playPauseBtn.removeEventListener(BtnEvent.ACTIVATED, playPauseBtn_activated);
				_playPauseBtn.removeEventListener(BtnEvent.DEACTIVATED, playPauseBtn_deactivated);
			}
			_playPauseBtn = value;
			(_playPauseBtn)
			{
				_playPauseBtn.addEventListener(BtnEvent.ACTIVATED, playPauseBtn_activated);
				_playPauseBtn.addEventListener(BtnEvent.DEACTIVATED, playPauseBtn_deactivated);
			}
		}
		
		public function get progressBar():Iscroller 
		{
			return _progressBar;
		}
		
		public function set progressBar(value:Iscroller):void 
		{
			if (_progressBar)
			{
				
			}
			_progressBar = value;
			if (_progressBar)
			{
				
			}
		}
		
		

		public function load(url:String):void
		{
			snd = new Sound();
			snd.load(new URLRequest(url));
			//sndChannel = snd.play();
			snd.addEventListener(ProgressEvent.PROGRESS, progressHandler,false,0,true);
			snd.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler,false,0,true);
			sndChannel.addEventListener(Event.SOUND_COMPLETE, sndComplete,false,0,true);
			sndTransform.volume = 0.9;
			sndChannel.soundTransform = sndTransform;
			//controls.playPause.gotoAndStop("pause");
			addEventListener(Event.ENTER_FRAME, soundProgress,false,0,true);
		}
		//public
		public function play():void
		{
			if (isPlaying) return;
			if (playPauseBtn) playPauseBtn.activate();
			else _play();
		}
		public function pause():void
		{
			if (!isPlaying) return;
			if (playPauseBtn) playPauseBtn.desactivate();
			else _pause();
		}
		public function stop():void
		{
			pause();
			goto(0);
		}
		public function clear():void
		{
			
		}
		public function goto(progress:Number):void
		{
			
		}
		
		/* INTERFACE scrollers.interfaces.IscrollController */
		
		public function scrollTo(pos:Number, duration:Object = 0, onComplete:Function = null, trigger:Object = 'external', noSnap:Boolean = false):void 
		{
			position = pod;
		}
		
		public function get position():Number 
		{
			return _position;
		}
		
		public function set position(value:Number):void 
		{
			_position = value;
		}
		
		public function get props():ScrollProperties 
		{
			return _props;
		}
		
		public function set props(value:ScrollProperties):void 
		{
			_props = value;
		}
		
		public function snap(onComplete:Function = null):void 
		{
			
		}
		//private:
		private function _play():void
		{
			if (!snd)
			{
				stop();
			}
			_isPlaying = true;
			sndChannel = snd.play();
		}
		private function _pause():void
		{
			if (!snd)
			{
				stop();
			}
		}
		private function _stop():void
		{
			
		}
		private function _clear():void
		{
			
		}
		private function _goto(progress:Number):void
		{
			if (!snd)
			{
				stop();
			}
		}
		//events:
		private function playPauseBtn_activated(e:BtnEvent):void 
		{
			_play();
		}
		
		private function playPauseBtn_deactivated(e:BtnEvent):void 
		{
			_pause();
		}
		//getter:
		public function get isPlaying():Boolean 
		{
			if (playPauseBtn)
			return playPauseBtn.isActive;
			else
			return _isPlaying;
		}
		
	}

}