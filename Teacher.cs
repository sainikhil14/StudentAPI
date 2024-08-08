using System;
using System.Collections.Generic;

namespace AspCoreWebAPICrud.Models;

public partial class Teacher
{
    public int TeacherId { get; set; }

    public string Name { get; set; } = null!;
}
