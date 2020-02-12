using System;
using System.Collections.Generic;
using System.Text;

namespace TypeLib
{
	public class Station
	{
		public int StationID { get; set; }
		public string StationName { get; set; }
		public int StationTypeID { get; set; }
		public int InBuilding { get; set; }
		public bool Activated { get; set; }
		public bool Visible { get; set; }

	}
}
