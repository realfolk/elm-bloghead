module Bloghead.Api exposing (getPosts, posts)

import Bloghead.Post as Post exposing (Post)
import Task
import Time


getPosts : Cmd (List Post)
getPosts =
    Task.succeed posts
        |> Task.perform identity



-- DATA


defaultPostBody : String
defaultPostBody =
    """
# Titulum speque inter ausis

## Animo neque bracchia versa sua manu contigit

Lorem markdownum Sigea vastius. Ait pectore est huic glaebam se forte vertuntur
herbae splendenti sedet, arvis. Ritus salutantum omnes grana; sed colla,
quodque?

> Duo [nec](http://inportuna-minimae.net/) figura oscula voluptas secuta bis
> pariterque, transit eventu. Est melioribus pervenit aere, hinc haerentem felix
> animo mutua quin.

## Proceres inutile lacrimisque verba haesit

Flexus *nullumque caelo*: ex miranti solvere exsatiata opacae: fisso,
foribusque. Licet laetor acer concumbere tamen perstet alta ambustaque tenendae
exsanguemque filia propera crescit viribus volunt. Equi bacae, tuo ferebat
cecidisse corpora et ferro vulnera misce. Diem leniat aeratas pridem dryadas et
nondum terga desine lavere intremuit prima Turno vide. Vastum choreas debuit
caelestia erat.

    if (cyberspaceMemory + clickJoystickSoftware) {
        record.plain /= -4;
        defaultJavaShortcut.fragmentation = vpi_petaflops_task(modeRaid(device,
                databaseControl), ansi_skin, snmp);
        google_switch_gis = navigation_video;
    }
    if (63) {
        file_io = osdDomainClick.macintoshDuplex(ram_mpeg -
                point_newsgroup_sata, yottabyte_multimedia_tablet * cps,
                hardProcessLock + 700585);
        brouterInterpreter = flaming_error;
    } else {
        orientation_spider_kilohertz = speakersLinkedinSmm;
    }
    if (key.rdram_throughput(bittorrent_programming, direct)) {
        layout_freeware(network, ddl.xmp_pipeline_drive(prom_irq));
        redundancyPdaScalable = syntax.cisc(e);
        refreshDrag.designPdf(paper_interlaced(p_illegal_social));
    } else {
        rssBoot = data * program;
    }
    if (3 + core(real_app, 3, lifo_software) >= client_bps_operating - 52) {
        wep_storage(terabyte, pram_jre_push(-5));
        yottabyteProxyRecursion.raw += 4;
    }

## Texebas esse moras

Cum visus laceraret interea et tremula Erigdupum comas. *In defixa Asopidos* de
commentaque quaeque eligit unius. Intercipe petebamus nec illo antraque hamos
nostro ulla de delere dignum.

## Nostri omnia iugalia

Bracchia ignibus acutis. Spem nunc dubites cornua ferre. Ad custos; autem aurea
ora lugubre unum?

- Turba est scire ut venit feralia fertilis
- Forsitan ebur regina quae ruinas nil di
- Iuvenemque Cereris

## Desinit dictaque patiar

Qui omnia Iunonia tota cum ora, sit Medon venenata sinistra, consequiturque
Pentheus, loco pars. Inmissa est artus nymphae: vero: sub armis formicas non,
segetes. Et **sunt sic**, exarsit *mirum in* Caeni parte clipeus falsum, mihi?

Sceleris corpora humanum prior docebo; nulla ipse Atlas tamen exiguamque
placidique **medio** infregit capit; donec! Denique timor exsereret flammas?
Triplex vires mersitque arbore rapidum si fugatas putes propior fulvo.
"""


posts : List Post
posts =
    [ Post.new
        "This is the first post."
        "Mary Nara"
        (Time.millisToPosix 0)
        defaultPostBody
    , Post.new
        "This is the second post."
        "Beef Sausage"
        (Time.millisToPosix 100000)
        defaultPostBody
    , Post.new
        "This is the third post."
        "Papa Sta"
        (Time.millisToPosix 200000)
        defaultPostBody
    ]
