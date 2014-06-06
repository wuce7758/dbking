package ${package};
		
import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.xml.bind.annotation.adapters.XmlJavaTypeAdapter;

import org.sosostudio.dbunifier.autocode.TimestampXmlAdapter;
import org.sosostudio.dbunifier.util.StringUtil;

/**
 * ${table.name}
 *
 * @author generated by db-unifier autocode
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "${table.name}")
public class ${table.definationName} implements Serializable {

	public static final String ${table.name} = "${table.name}";
	<#list table.columnList as column>

	public static final String ${column.name} = "${column.name}";
	</#list>
	<#list table.columnList as column>
		<#if column.type == "STRING" || column.type == "NUMBER" || column.type == "TIMESTAMP">

			<#if column.primaryKey>
	@Id
			</#if>
	@Column(name = "${column.name}")
	private ${column.type.type} ${column.variableName};
		</#if>
	</#list>
	
	<#list table.columnList as column>
		<#if column.type == "STRING" || column.type == "NUMBER" || column.type == "TIMESTAMP">

			<#if column.type == "TIMESTAMP">
	@XmlJavaTypeAdapter(TimestampXmlAdapter.class)
			</#if>
	public ${column.type.type} get${column.definationName}() {
		return ${column.variableName};
	}

	public void set${column.definationName}(${column.type.type} ${column.variableName}) {
		this.${column.variableName} = ${column.variableName};
	}
		</#if>
	</#list>
	
	public void truncateString() {
	<#list table.columnList as column>
		<#if column.type == "STRING">
		${column.variableName} = StringUtil.truncate(${column.variableName}, ${column.size});
		</#if>
	</#list>
	}

}