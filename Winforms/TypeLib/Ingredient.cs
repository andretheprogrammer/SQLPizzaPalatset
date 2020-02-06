using System;
using System.Collections.Generic;
using System.Text;

namespace TypeLib
{
    public class Ingredient
    {
        public int IngredientID { get; set; }
        public string IngredientName { get; set; }
        public int Price { get; set; }
        public bool Activated { get; set; }
        public bool Visible { get; set; }
    }
}
