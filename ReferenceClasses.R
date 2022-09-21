Student <- setRefClass(Class = "Student", 
                       fields = list(name = "character", age = "numeric", 
                                                        academic_year = "numeric", credits = "numeric",
                                                        courses = "list", id = "character"),
                       methods = list(greet = function(){
                           return(paste("Hi there! my name is ", name))
                       },
                       getEmail = function(){
                           return(paste(gsub(" ", "_", name), "@dummy.univ.xyz.edu", sep = ""))
                       },
                       addCredits = function(n){
                           credits <<- credits + n
                           message(paste("Credits of ", name, " is now ", credits))
                       },
                       isSenior = function(){
                           if(academic_year == 4) return(TRUE)
                           else return(FALSE)
                       }))

Jhonnie <- new("Student", name = "Jhonnie Brussels", age = 24, academic_year = 3, credits = 87,
               courses = list("Ecology", "Statistics", "Basic algebra", "Pomology", "Fundamentals of Psychology"),
               id = "STD4YR3NT67")

class(Jhonnie)
Jhonnie$id
Jhonnie$academic_year
Jhonnie$isSenior()
Jhonnie$getEmail()

Damien <- new("Student", name = "Damien Javier Gonzalez", age = 30, academic_year = 4, credits = 98,
              courses = list("Linear algebra", "Computational algorithms", "Procedural decomposition"),
              id = "SCS45Rt76N98")
Damien$isSenior()
Damien$getEmail()
Damien$getClass()
Damien$courses
Damien$credits
Damien$addCredits(8)
Damien$credits

# defining a subclass using reference classes

GraduateStudent <- setRefClass(Class = "GradStudent", contains = "Student",
                               fields = list(research_topic = "character", researchDegree = "logical", nPublications = "numeric",
                                             supervisor = "character", coSupervisor = "character", DegreeType = "character",
                                             publications = "list"),
                               methods = list(isPhD = function(){
                                   if(DegreeType == "Doctoral") return(TRUE)
                                   else return(FALSE)
                               },
                               isResearchStudent = function(){
                                   if(researchDegree == TRUE) return(TRUE)
                                   else return(FALSE)
                               },
                               newPublications = function(n){
                                   nPublications <<- nPublications + n
                                   message(name, "now has published a total of ", nPublications, " research articles!")
                               }))



Suzanne <- new(Class = "GradStudent", name = "Suzanne Marline Jeloyne", age = 32, academic_year = 2,
               credits = 108, id = "PG45STD435SZ", courses = list("Advanced algorithms", "Hash maps", "Software Engineering"),
               research_topic = "Search tree Intel x64 assembly algorithms using SIMD vectorization",
               researchDegree = TRUE, nPublications = 7, supervisor = "Prof. Janice Z. Edelmann",
               coSupervisor  = "Prof. Natakzi Matsumizo", DegreeType = "MSc",
               publications = list("Efficiency of SIMD vectorized x64 assembly search trees",
                                   "Benchmarking SIMD algorithms on Intel i3, i5, i7, i9 & AMD Ryzen, ThreadRipper CPus"))

Suzanne$academic_year
Suzanne$isPhD()
Suzanne$isSenior()
Suzanne$isResearchStudent()
Suzanne$supervisor
Suzanne$newPublications(10)
Suzanne$DegreeType <- "Doctoral"
Suzanne$isPhD()

