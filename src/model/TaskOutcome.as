package model 
{
	/**
	 * ...
	 * @author Juanola
	 */
	public class TaskOutcome 
	{
		
		private var _technicalGoodDemands : Array;
		private var _generationGoodDemands : Array;
		private var _amountGood : Array;
		
		private var _technicalMediumDemands : Array;
		private var _generationMediumDemands : Array;
		private var _amountMedium : Array;
		
		private var _goodTime : int;
		private var _mediumTime : int;
		private var _badTime : int;
		
		private var _goodResult : int;
		private var _mediumResult : int;
		private var _badResult : int;
		
		public function TaskOutcome(technicalGoodDemands : Array, generationGoodDemands : Array, amountGood : Array,
									technicalMediumDemands : Array, generationMediumDemands : Array, amountMedium : Array,
									goodTime : int, mediumTime : int, badTime :int,
									goodResult : int, mediumResult : int, badResult : int) 
		{
			this._technicalGoodDemands = technicalGoodDemands;
			this._generationGoodDemands = generationGoodDemands;
			this._amountGood = amountGood;
			
			this._technicalMediumDemands = technicalMediumDemands;
			this._generationMediumDemands = generationMediumDemands;
			this._amountMedium = amountMedium;
			
			this._goodTime = goodTime;
			this._mediumTime = mediumTime;
			this._badTime = badTime;
			
			this._goodResult = goodResult;
			this._mediumResult = mediumResult;
			this._badResult = badResult;		
		}
		
		public function getOutcome(technicalSelected : Array, generationSelected : Array, amountSelected : Array):Object {
			var outcome : Object = new Object();
			outcome.time = 0;
			outcome.result = 0;			
			return 0;			
		}
		
		
		
	}

}