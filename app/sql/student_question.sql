-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: student
-- ------------------------------------------------------
-- Server version	9.2.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `question`
--

DROP TABLE IF EXISTS `question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `question` (
  `id` int NOT NULL,
  `type` varchar(50) NOT NULL COMMENT '题目类型',
  `content` text NOT NULL COMMENT '题目内容',
  `answer` text NOT NULL COMMENT '题目答案',
  `analysis` text NOT NULL COMMENT '答案解析',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='试题表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question`
--

/*!40000 ALTER TABLE `question` DISABLE KEYS */;
INSERT INTO `question` VALUES (1,'fill','一、看拼音写词语：\n1. liáng guō（ ）\n2. cōng huì（ ）\n3. zào yì（ ）\n4. kǒng zǐ yuē（ ）\n5. jiā qín（ ）','梁国 聪慧 造诣 孔子曰 家禽','通过拼音写词语，考察学生对拼音的识记能力','2025-03-27 12:48:23','2025-03-27 12:48:23'),(2,'fill','二、解释下面句子中带点的字。\n1. 孔君平诣其父，父不在，乃呼儿出。\n诣： \n乃： \n2. 孔指以示儿曰。\n示： \n曰： \n3. 未闻孔雀是夫子家禽\n未：     \n闻： ','拜见 于是，就 给……看 说 没有 听见','通过解释句子中带点的字，考察学生对词语的理解能力','2025-03-27 12:48:23','2025-03-27 12:48:23'),(3,'text','三、仔细读下面的句子，回答问题。\n孔指以示儿曰：\"此是君家果。\"儿应声答曰：\"未闻孔雀是夫子家禽。\"\n1. 对话意思：\n2. 对话精妙极了，妙在何处？\"','1.孔君平指着杨梅给杨家儿子看，说：\"这是你家的果子。\"杨家儿子答道：\"没有听说孔雀是您家的家禽。2.都根据人物姓氏来借题发挥，杨家儿子反应极快，才思敏捷。','通过阅读对话，回答问题，考察学生对课文的理解能力','2025-03-27 12:48:23','2025-03-27 12:48:23'),(4,'fill','四、仿照下面句子，以四季的水果作内容写两个句子。\n春天的杨梅吮吸着甘露，在雨水中欢笑。\n夏天的西瓜，__________。\n秋天的橘子，__________。','夏天的西瓜沐浴着阳光，在藤蔓上微笑。\n秋天的橘子感受着秋风，在枝头上歌唱。','通过仿照句子，写两个句子，考察学生的语言表达能力','2025-03-27 12:48:23','2025-03-27 12:48:23'),(5,'fill','五、熟读课文，再填空。\n梁国杨氏之子__________，甚__________。孔君平__________其父，父不在......果有杨梅。孔指以示儿\n曰：__________\"。\"儿应声答曰：\"__________。\"','九岁 聪惠 诣 此是君家果 未闻孔雀是夫子家禽','通过熟读课文，填空，考察学生对课文的理解能力','2025-03-27 12:48:23','2025-03-27 12:48:23');
/*!40000 ALTER TABLE `question` ENABLE KEYS */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-27 20:51:25
