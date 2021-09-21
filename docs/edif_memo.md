(EDIF
    [EdifFileName]
    (EdifVersion 2 0 0)
    (EdifLevel 1)
    (KeywordMap (KeywordLevel 0) (Comment))
    (Status)
    (External/Library [LibNameDef] (EdifLevel 1) (Technology)
	    (Status)...
        (Cell "" (cellType TIE/RIPPER/GENERIC) (status)...
            (viewMap
                (portMap (portRef)... (portGroup)...)...
                (portBackAnotate (portRef) ...)... 
                (instanceMap (instanceRef)... (instanceGroup)...)... 
                (instanceBackAnotate (instanceRef) ...)... 
                (netMap (netRef)... (netGroup)...)... 
                (netBackAnotate ...)...
            )...
            (view "" (viewType MASKLAYOUT/PCBLAYOUT/NETLIST/SCHEMATIC/SYMBOLIC/
                                BEHAVIOR/LOGICMODEL/DOCUMENT/GRAPHIC/STRANGER)
                (status)...
                (interface
                    (port)...
                    (portBundle)...
                    (symbol)...
                    (protectionFrame)...

                    (arrayrelatedinfo (baseArray)/(arraySite)/(arrayMacro)))...
                    (parameter [nameDef] [typedValue] (Uint)?)... 

                    (joined (portRef)* (portList)* (globalPortRef)*)... 
                    (weakJoined (portRef)* (portList)* (joined)*)... 
                    (mustJoin (portRef)* (portList)* (weakJoined)* (joined)*)... 
                    (permutable ...)... 

                    (timing ...)... (simurate ...)... 
                    (designator ""/(stringDisplay))... 
                    (property)...
                )
                (contents
                    (offPageConnector)...
                    (figure)...
                    (section "" (section)/""/(instance)...)...
                    (instance)...
                    (page "" 
                        (pageSize (rectangle (pt) (pt)))
                        (instance)
                        (net)
                        (netBundle)
                        (commentgraphics)
                        (portimplementation)
                        (boundingbox)
                    )...
                    (net)...
                    (netBundle)...
                    (commentGraphics 
                        (annotate) 
                        (figure) 
                        (instance) 
                        (boundingbox) 
                        (property)
                    )...
                    (portimplementation)...
                    (boundBox (rectangle (pt) (pt)))...
                    (timing ...)... (simulate ...)... (when ...)...
                    (follow ...)... (logicPort ...)...
                )...
                (property)...
            )...
            (Property)...)...
    )
    (Design [DesignNameDef] 
        (CellRef [CellNameRef] (LibraryRef LibNameRef)?)
        (Status)...
	    (Property)...
    )
)

###################################

(port ""
    (direction INOUT/INPUT/OUTPUT)
    (unused)
    (portDelay ...)
    (designator ""/(strDisplay))
    (DcFanInLoad) (DcFanOutLoad) (DcMaxFanIn) (DcMaxFanOut) (AcLoad)
    (Property)...
)
(portBundle ""
    (listOfPorts (port)... (portBundle)...)
    (Property)...
)
(symbol
    (portimplementation)
    (figure)
    (instance)
    (commentGraphics)
    (annotate)
    (pageSize)
    (boundBox)
    (propertyDisplay)
    (KeywordDisplay)
    (ParameterDisplay)
    (Property)
)
(protectionFrame
    (portImplementation)...
    (figure)
    (instance)
    (commentGraphics)
    (boundBox)
    (PropDisp) 
    (KeywordDisplay) 
    (parameterDisplay [nameRef] (display)) 
    (Property)
)

(portImplementation
    (Name)/[Ident]
    (figure)
    (connectLocation)
    (instance)
    (commentGraphics)
    (propertyDisplay)
    (KeywordDisplay)
    (Property)
)





(figure [FigGrpNameDef]/(FigureGroupoverride)
    (Circle (pt) (pt) (Property)...)
	(Dot (pt) (Property)...)
    (OpenShape (Curve) (Property)...)
    (Path (PointList (pt)...) (Property)...)
    (Polygon (PointList (pt)...) (Property)...)
    (Rectangle (pt) (pt) (Property)...)
    (Shape (Curve (Arc (pt) (pt) (pt))/(pt 0 0)...) (Property)...)
)


(portimplementation)






celltype:
    TIE/RIPPER/GENERIC


nameRef:
    [Ident]
    (Name [Ident]
        (Display
            [FigGrpNameRef]/(FigureGroupride
                (FigureGroupRef [FigGrpNameRef] (LibraryRef [name])?)
                (CornerType)
                (EndType)
                (PathWidth)
                (BorderWidth)
                (Color)
                (FillPattern)
                (BorderPat)
                (TextHeight)
                (Visible)
                (Property)
            )
            (justify 
                CENTERCENTER/CENTERLEFT/CENTERRIGHT/
                LOWERCENTER/LOWERLEFT/LOWERRIGHT/
                UPPERCENTER/UPPERLEFT/UPPERRIGHT
            )
            (orientation R0/R90/R270/MX/MY/MYR90/MXR90)
            (Origin (pt 0 0))
    )



(design "" (CellRef "" (LibraryRef "")?))
(viewRef "" (CellRef "" (LibraryRef "")?)?)

(instance "" (viewRef)? (viewList)? (Transform)?)
(instanceRef "" (InstanceRef)? (viewRef)?)
(netRef "" (netRef)? (instanceRef)? (viewRef)?)
(portRef "" (portRef)? (instanceRef)? (viewRef)?)
(site (viewRef) (trasform)?)
(viewList (viewRef)... (viewList)...)

(figureGroupRef "" (LibraryRef "")?)

(globalportRef)



(Status
    (Written
        (TimeStamp 0 0 0 0 0 0)
        (Author "")*
        (Program "" (Version "")?)*
        (DataOrigin"" (Version "")?)*
        (Property)
    )
)

(Property namedef (TypedValue ...)
    (Owner "")?
    (Unit 
        DISTANCE/CAPACITANCE/CURRENT/RESISTANCE/TEMPERATURE/
        TIME/VOLTAGE/MASS/FREQUENCY/INDUCTANCE/ENERGY/POWER/
        CHARGE/CONDUCTANCE/FLUX/ANGLE
    )?
    (Property ...)?
    (Comment "")?
)
(Comment "")
(UserData [Ident] [Int]/[Str]/[Ident]/(Keyword [Int]/[Str]/[Ident]/(Keyword ...)))

NameDef:
    [Ident]
    [Ident] (Name [Ident] (Display))
    [Ident] (Rename [Ident](Name [Ident] (Display)) ""/(strDisplay))

TypedValue:
    (Boolean True/False/(BooleanDisp True/False (Display)) ...)
    (Integer 0/(IntDisplay 0 (Display)) ...)
    (MinoMax Mnm/ScaledInt/(MinoMaxDisplay Mnm/ScaledInt (Display)))
    (Number 0/(e 0 0) (NumbDisplay 0/(e 0 0) (Display)) (Number))
    (Point )
	   |	Point
	   |	String
    (String ""/(StrDisplay "" (Display))/(String))

           (BooleanMap True/False))

Scale:
    (Scale 0/(e 0 0) 0/(e 0 0) (Uint
        DISTANCE/CAPACITANCE/CURRENT/RESISTANCE/TEMPERATURE/
        TIME/VOLTAGE/MASS/FREQUENCY/INDUCTANCE/ENERGY/POWER/
        CHARGE/CONDUCTANCE/FLUX/ANGLE))
(Undefined)
(Unconstrained)
