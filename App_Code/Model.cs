using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

public class LoginINFO
{
    string _MemberGuid = string.Empty;
    string _MemberName = string.Empty;
    string _MemberClass = string.Empty;
    string _MemberCompetence = string.Empty;



    public string MemberGuid { get { return _MemberGuid; } set { _MemberGuid = value; } }
    public string MemberName { get { return _MemberName; } set { _MemberName = value; } }
    public string MemberClass { get { return _MemberClass; } set { _MemberClass = value; } }
    public string MemberCompetence { get { return _MemberCompetence; } set { _MemberCompetence = value; } }

}


public class sy_Member
{
    public string mbGuid { get; set; }
    public string mbName { get; set; }
    public string mbJobNumber { get; set; }
    public string mbId { get; set; }
    public string mbPassword { get; set; }
    public string mbCom { get; set; }

}