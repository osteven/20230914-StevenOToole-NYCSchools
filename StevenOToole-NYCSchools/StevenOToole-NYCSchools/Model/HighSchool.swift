//
//  HighSchool.swift
//  StevenOToole-NYCSchools
//
//  Created by Steven O'Toole on 9/14/23.
//

import Foundation

public typealias DBNIdentifier = String

// MARK: - HighSchool

public struct HighSchool: Identifiable, Decodable {
    public let id: String
    public let name: String
    public let latitude: Double?
    public let longitude: Double?
    public let totalStudents: Int?
    public let email: String?
    public let overviewParagraph: String
    public var scores: SATScore?

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        if let latitudeString = try container.decodeIfPresent(String.self, forKey: .latitude) {
            latitude = Double(latitudeString)
        } else {
            latitude = nil
        }
        if let longitudeString = try container.decodeIfPresent(String.self, forKey: .longitude) {
            longitude = Double(longitudeString)
        } else {
            longitude = nil
        }
        let totalStudentsString = try container.decode(String.self, forKey: .totalStudents)
        totalStudents = Int(totalStudentsString)
        email = try container.decodeIfPresent(String.self, forKey: .email)
        overviewParagraph = try container.decode(String.self, forKey: .overviewParagraph)
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "dbn"
        case name = "school_name"
        case latitude
        case longitude
        case totalStudents = "total_students"
        case email = "school_email"
        case overviewParagraph = "overview_paragraph"
    }
}

extension HighSchool: Equatable, Hashable {
    public static func == (lhs: HighSchool, rhs: HighSchool) -> Bool {
        lhs.id == rhs.id
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - Mock

#if DEBUG
extension HighSchool {
    init() {
        id = "mock"
        name = "Clinton School Writers & Artists, M.S. 260"
        overviewParagraph = """
    Students who are prepared for college must have an education that encourages them to take risks as they produce and perform. Our college preparatory curriculum develops writers and has built a tight-knit community. Our school develops students who can think analytically and write creatively. Our arts programming builds on our 25 years of experience in visual, performing arts and music on a middle school level. We partner with New Audience and the Whitney Museum as cultural partners. We are a International Baccalaureate (IB) candidate school that offers opportunities to take college courses at neighboring universities.
    """
        latitude = nil
        longitude = nil
        totalStudents = 99
        email = "admissions@theclintonschool.net"
        scores = SATScore()
    }
    
    public static var mockJSON: String { """
[{"dbn":"02M260","school_name":"Clinton School Writers & Artists, M.S. 260","boro":"M","overview_paragraph":"Students who are prepared for college must have an education that encourages them to take risks as they produce and perform. Our college preparatory curriculum develops writers and has built a tight-knit community. Our school develops students who can think analytically and write creatively. Our arts programming builds on our 25 years of experience in visual, performing arts and music on a middle school level. We partner with New Audience and the Whitney Museum as cultural partners. We are a International Baccalaureate (IB) candidate school that offers opportunities to take college courses at neighboring universities.","school_10th_seats":"1","academicopportunities1":"Free college courses at neighboring universities","academicopportunities2":"International Travel, Special Arts Programs, Music, Internships, College Mentoring English Language Learner Programs: English as a New Language","ell_programs":"English as a New Language","neighborhood":"Chelsea-Union Sq","building_code":"M868","location":"10 East 15th Street, Manhattan NY 10003 (40.736526, -73.992727)","phone_number":"212-524-4360","fax_number":"212-524-4365","school_email":"admissions@theclintonschool.net","website":"www.theclintonschool.net","subway":"1, 2, 3, F, M to 14th St - 6th Ave; 4, 5, L, Q to 14th St-Union Square; 6, N, R to 23rd St","bus":"BM1, BM2, BM3, BM4, BxM10, BxM6, BxM7, BxM8, BxM9, M1, M101, M102, M103, M14A, M14D, M15, M15-SBS, M2, M20, M23, M3, M5, M7, M8, QM21, X1, X10, X10B, X12, X14, X17, X2, X27, X28, X37, X38, X42, X5, X63, X64, X68, X7, X9","grades2018":"6-11","finalgrades":"6-12","total_students":"376","extracurricular_activities":"CUNY College Now, Technology, Model UN, Student Government, School Leadership Team, Music, School Musical, National Honor Society, The Clinton Post (School Newspaper), Clinton Soup (Literary Magazine), GLSEN, Glee","school_sports":"Cross Country, Track and Field, Soccer, Flag Football, Basketball","attendance_rate":"0.970000029","pct_stu_enough_variety":"0.899999976","pct_stu_safe":"0.970000029","school_accessibility_description":"1","directions1":"See theclintonschool.net for more information.","requirement1_1":"Course Grades: English (87-100), Math (83-100), Social Studies (90-100), Science (88-100)","requirement2_1":"Standardized Test Scores: English Language Arts (2.8-4.5), Math (2.8-4.5)","requirement3_1":"Attendance and Punctuality","requirement4_1":"Writing Exercise","requirement5_1":"Group Interview (On-Site)","offer_rate1":"Â—57% of offers went to this group","program1":"M.S. 260 Clinton School Writers & Artists","code1":"M64A","interest1":"Humanities & Interdisciplinary","method1":"Screened","seats9ge1":"80","grade9gefilledflag1":"Y","grade9geapplicants1":"1515","seats9swd1":"16","grade9swdfilledflag1":"Y","grade9swdapplicants1":"138","seats101":"YesÂ–9","admissionspriority11":"Priority to continuing 8th graders","admissionspriority21":"Then to Manhattan students or residents","admissionspriority31":"Then to New York City residents","grade9geapplicantsperseat1":"19","grade9swdapplicantsperseat1":"9","primary_address_line_1":"10 East 15th Street","city":"Manhattan","zip":"10003","state_code":"NY","latitude":"40.73653","longitude":"-73.9927","community_board":"5","council_district":"2","census_tract":"52","bin":"1089902","bbl":"1008420034","nta":"Hudson Yards-Chelsea-Flatiron-Union Square                                 ","borough":"MANHATTAN"},
{"dbn":"21K728","school_name":"Liberation Diploma Plus High School","boro":"K","overview_paragraph":"The mission of Liberation Diploma Plus High School, in partnership with CAMBA, is to develop the student academically, socially, and emotionally. We will equip students with the skills needed to evaluate their options so that they can make informed and appropriate choices and create personal goals for success. Our year-round model (trimesters plus summer school) provides students the opportunity to gain credits and attain required graduation competencies at an accelerated rate. Our partners offer all students career preparation and college exposure. Students have the opportunity to earn college credit(s). In addition to fulfilling New York City graduation requirements, students are required to complete a portfolio to receive a high school diploma.","school_10th_seats":"1","academicopportunities1":"Learning to Work, Student Council, Advisory Leadership, School Newspaper, Community Service Group, School Leadership Team, Extended Day/PM School, College Now","academicopportunities2":"CAMBA, Diploma Plus, Medgar Evers College, Coney Island Genera on Gap, Urban Neighborhood Services, Coney Island Coalition Against Violence, I Love My Life Initiative, New York City Police Department","academicopportunities3":"The Learning to Work (LTW) partner for Liberation Diploma Plus High School is CAMBA.","ell_programs":"English as a New Language","language_classes":"French, Spanish","neighborhood":"Seagate-Coney Island","building_code":"K728","location":"2865 West 19th Street, Brooklyn, NY 11224 (40.576976, -73.985413)","phone_number":"718-946-6812","fax_number":"718-946-6825","school_email":"scaraway@schools.nyc.gov","website":"schools.nyc.gov/schoolportals/21/K728","subway":"D, F, N, Q to Coney Island  Â–  S llwell Avenue","bus":"B36, B64, B68, B74, B82, X28, X38","grades2018":"School is structured on credit needs, not grade level","finalgrades":"School is structured on credit needs, not grade level","total_students":"206","addtl_info1":"The Learning to Work (LTW) program assists students in overcoming obstacles that impede their progress toward a high school diploma. LTW offers academic and student support, career and educational exploration, work preparation, skills development, and internships that prepare students for rewarding employment and educational experiences after graduation. These LTW supports are provided by a community-based organization (CBO) partner.","extracurricular_activities":"Advisory Leadership, Student Council, Community Service Leadership, School Leadership Team, A er-School Enrichment, Peer Tutoring, School Newspaper","school_sports":"Basketball ","attendance_rate":"0.550000012","pct_stu_enough_variety":"0.899999976","pct_stu_safe":"0.959999979","transfer":"1","directions1":"Students must attend an Open House and personalized intake meeting. To find out about open houses, students should call the school at 718-946-6812 or visit our website.","program1":"Liberation Diploma Plus High School","code1":"L72A","interest1":"Humanities & Interdisciplinary","method1":"Limited Unscreened","seats9ge1":"N/A","grade9gefilledflag1":"N/A","grade9geapplicants1":"N/A","seats9swd1":"N/A","grade9swdfilledflag1":"N/A","grade9swdapplicants1":"N/A","seats101":"Yes-New","eligibility1":"For Current 8th Grade Students Â– Open only to students who are at least 15 1/2 years of age and entering high school for the first time. For Other Students Â– Open only to students who are at least 16 years of age and have attended another high school for at least one year","grade9geapplicantsperseat1":"N/A","grade9swdapplicantsperseat1":"N/A","primary_address_line_1":"2865 West 19th Street","city":"Brooklyn","zip":"11224","state_code":"NY","latitude":"40.57698","longitude":"-73.9854","community_board":"13","council_district":"47","census_tract":"326","bin":"3329331","bbl":"3070200039","nta":"Seagate-Coney Island                                                       ","borough":"BROOKLYN "},
{"dbn":"08X282","school_name":"Women's Academy of Excellence","boro":"X","overview_paragraph":"The WomenÂ’s Academy of Excellence is an all-girls public high school, serving grades 9-12. Our mission is to create a community of lifelong learners, to nurture the intellectual curiosity and creativity of young women and to address their developmental needs. The school community cultivates dynamic, participatory learning, enabling students to achieve academic success at many levels, especially in the fields of math, science, and civic responsibility. Our scholars are exposed to a challenging curriculum that encourages them to achieve their goals while being empowered to become young women and leaders. Our Philosophy is GIRLS MATTER!","academicopportunities1":"Genetic Research Seminar, Touro College Partnership, L'Oreal Roll Model Program, Town Halls, Laptop carts, SMART Boards in every room, Regents Prep.","academicopportunities2":"WAE Bucks Incentive Program, Monroe College JumpStart, National Hispanic Honor Society, National Honor Society,Lehman College Now, Castle Learning.","academicopportunities3":"Pupilpath, Saturday school, Leadership class, College Trips, Teen Empowerment Series, College Fairs, Anti-bullying Day, Respect for All, Career Day.","academicopportunities4":"PEARLS Awards, Academy Awards, Rose Ceremony/Parent Daughter Breakfast, Ice Cream Social.","academicopportunities5":"Health and Wellness Program","ell_programs":"English as a New Language","language_classes":"Spanish","diplomaendorsements":"Science","neighborhood":"Castle Hill-Clason Point","shared_space":"Yes","building_code":"X174","location":"456 White Plains Road, Bronx NY 10473 (40.815043, -73.85607)","phone_number":"718-542-0740","fax_number":"718-542-0841","school_email":"sburns@schools.nyc.gov","website":"schools.nyc.gov/SchoolPortals/08/X282","subway":"N/A","bus":"Bx22, Bx27, Bx36, Bx39, Bx5","grades2018":"9-12","finalgrades":"9-12","total_students":"338","start_time":"8:20am","end_time":"2:45pm","addtl_info1":"Community Service Expected; Online Grading System; Saturday Programs; Student/Parent Orientation; Uniform","extracurricular_activities":"Academy of Health, Advisory, Annual Breast Cancer Walk, Purses for Life, Ambassadors, Conflict Resolution Program-Effective Alternatives in Reconciliation Services (EARS), Peer Tutoring, Student Government, Step Team, Cheerleading, Big Sister/Little Sister Program, Chorus","psal_sports_boys":"Baseball, Basketball, Cross Country, Fencing","psal_sports_girls":"Basketball, Cross Country, Indoor Track, Outdoor Track, Softball, Volleyball","psal_sports_coed":"Stunt","graduation_rate":"0.612999976","attendance_rate":"0.790000021","pct_stu_enough_variety":"0.330000013","college_career_rate":"0.486000001","pct_stu_safe":"0.629999995","girls":"1","school_accessibility_description":"1","offer_rate1":"Â—89% of offers went to this group","program1":"WomenÂ’s Academy of Excellence","code1":"Y01T","interest1":"Science & Math","method1":"Limited Unscreened","seats9ge1":"86","grade9gefilledflag1":"N","grade9geapplicants1":"330","seats9swd1":"22","grade9swdfilledflag1":"N","grade9swdapplicants1":"52","seats101":"No","admissionspriority11":"Priority to New York City residents who attend an information session","admissionspriority21":"Then to New York City residents","eligibility1":"Open only to female students","grade9geapplicantsperseat1":"4","grade9swdapplicantsperseat1":"2","primary_address_line_1":"456 White Plains Road","city":"Bronx","zip":"10473","state_code":"NY","latitude":"40.81504","longitude":"-73.8561","community_board":"9","council_district":"18","census_tract":"4","bin":"2020580","bbl":"2034780018","nta":"Soundview-Castle Hill-Clason Point-Harding Park                            ","borough":"BRONX    "}]
"""
    }
}
#endif
