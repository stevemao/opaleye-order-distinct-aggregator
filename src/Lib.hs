module Lib
    ( someFunc
    ) where
import Opaleye
import           Data.Profunctor.Product
import qualified Opaleye.Aggregate as A
import           Control.Lens
import qualified Database.PostgreSQL.Simple            as PGS
import qualified Data.Text                             as T
import Control.Monad

personTable :: Table (Field SqlText, Field SqlInt4)
                    (Field SqlText, Field SqlInt4)
personTable = table "personTable" (p2 ( tableField "name"
                                      , tableField "child_age" ))

thisDoesNotWork :: Select (Field SqlText, Field SqlInt4)
thisDoesNotWork = aggregateOrdered (asc (^. _2)) (distinctAggregator (p2 (A.groupBy, A.groupBy))) (selectTable personTable)

thisWorks :: Select (Field SqlText, Field SqlInt4)
thisWorks = aggregateOrdered (asc (^. _2)) ((p2 (A.groupBy, A.groupBy))) (distinct (selectTable personTable))

runPerson :: PGS.Connection
                 -> Select (Field SqlText, Field SqlInt4)
                 -> IO [(T.Text, Int)]
runPerson = runSelect

someFunc :: IO ()
someFunc = do
    conn <- PGS.connect PGS.ConnectInfo { PGS.connectHost = "localhost"
                                        , PGS.connectPort = 5432
                                        , PGS.connectUser = "myuser"
                                        , PGS.connectPassword = "mypassword"
                                        , PGS.connectDatabase = "mydatabase" } 

    void $ runPerson conn thisDoesNotWork
